report 50003 AgedTest1
{

    DefaultLayout = RDLC;
    RDLCLayout = 'ItemAgingReport2.rdl';
    Caption = 'Item Aging Reports test';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DataAccessIntent = ReadOnly;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";

            // column(ReportCreateUser; ReportCreateUser)
            // {

            // }
            // column(SystemCreatedBy; CreatedUser."Full Name")
            // {

            // }

            // column(SystemCreatedAt; SystemCreatedAt)
            // {

            // }
            // column(ApproverName; ApproveUser."Full Name")
            // {

            // }

            // column(ApprovalDateTime; Approver."Last Date-Time Modified")
            // {

            // }
            // column(Compname; CompanyInfo.Name)
            // {

            // }
            // column(CompAddress; CompanyInfo.Address)
            // {

            // }
            // column(CompAddress2; CompanyInfo."Address 2")
            // {

            // }
            // column(CompCity; CompanyInfo.City)
            // {

            // }
            // column(CompImage; CompanyInfo.Picture)
            // {

            // }


            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No.");
                column(Document_No_; "Document No.")
                {

                }
                column(Posting_Date; "Posting Date")
                {

                }
                column(Item_No_; "Item No.")
                {

                }
                // column(ItemDescription; )
                // {

                // }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Cost_Amount__Actual_; "Cost Amount (Actual)")
                {

                }
                trigger OnAfterGetRecord()
                begin
                    ;
                end;

                trigger OnPreDataItem()
                begin
                    // SetRange("Entry No.", "Item Register"."From Entry No.", "Item Register"."To Entry No.");
                end;
            }
            // trigger OnAfterGetRecord()
            // begin
            //     CreatedUser.Reset;
            //     if CreatedUser.Get(SystemCreatedBy) then
            //         CreatedUserSetup.Get(CreatedUser."User Name");
            // end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(AgedAsOf; EndingDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged As Of';
                        ToolTip = 'Specifies the date that you want the aging calculated for.';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period Length';
                        ToolTip = 'Specifies the period for which data is shown in the report. For example, enter "1M" for one month, "30D" for thirty days, "3Q" for three quarters, or "5Y" for five years.';
                    }
                    field(HeadingType; HeadingType)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Heading Type';
                        OptionCaption = 'Date Interval,Number of Days';
                        ToolTip = 'Specifies if the column heading for the three periods will indicate a date interval or the number of days overdue.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if EndingDate = 0D then
                EndingDate := WorkDate();
            if Format(PeriodLength) = '' then
                Evaluate(PeriodLength, '<1M>');
        end;
    }

    trigger OnPreReport()
    var
        FormatDocument: Codeunit "Format Document";
    begin
        StartDateTime := CurrentDateTime();
        ItemFilter := FormatDocument.GetRecordFiltersWithCaptions(Item);

        GLSetup.Get();

        // CalcDates();
        // CreateHeadings();

        PageGroupNo := 1;
        NextPageGroupNo := 1;
        ItemFilterCheck := (ItemFilter <> 'No.');

        CompanyDisplayName := COMPANYPROPERTY.DisplayName();
    end;

    trigger OnPostReport()
    begin
        FinishDateTime := CurrentDateTime();
        // LogReportTelemetry(StartDateTime, FinishDateTime, NumberOfLines);
    end;


    var
        GLSetup: Record "General Ledger Setup";
        PhsInventLedgerEntry: Record "Phys. Inventory Ledger Entry";
        ItemLedgEntryEndingDate: Record "Item Ledger Entry";
        TotalItemLedgEntry: array[5] of Record "Item Ledger Entry";
        GrandTotalItemLedgEntry: array[5] of Record "Item Ledger Entry";
        AgedItemLedgEntry: array[6] of Record "Item Ledger Entry";
        TempCurrency: Record Currency temporary;
        TempCurrency2: Record Currency temporary;
        TempCurrencyAmount: Record "Currency Amount" temporary;
        PeriodLength: DateFormula;
        PrintItemQty: Boolean;
        EndingDate: Date;
        AgingBy: Option "Posting Date";
        HeadingType: Option "Date Interval","Number of Days";
        NewPagePerItem: Boolean;
        PeriodStartDate: array[5] of Date;
        PeriodEndDate: array[5] of Date;
        HeaderText: array[5] of Text[30];
        Text000: Label 'Not Due';
        AfterTok: Label 'After';
        BeforeTok: Label 'Before';
        CurrencyCode: Code[10];
        Text002: Label 'days';
        Text004: Label 'Aged by %1';
        Text005: Label 'Total for %1';
        Text006: Label 'Aged as of %1';
        Text007: Label 'Aged by %1';
        NumberOfCurrencies: Integer;
        Text009: Label 'Due Date,Posting Date,Document Date';
        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.';
        PageGroupNo: Integer;
        NextPageGroupNo: Integer;
        ItemFilterCheck: Boolean;
        Text032Txt: Label '-%1', Comment = 'Negating the period length: %1 is the period length';
        ItemAgingReportCptnLbl: Label 'Item Aging Report';
        CurrReportPageNoCptnLbl: Label 'Page';
        AllQtyCptnLbl: Label 'All Quantity in Inventory';
        ItemAgedQtyCptnLbl: Label 'Item Aged Quantity';
        ILEEndDateQtyCptnLbl: Label 'Original Quantity ';
        ILEEndDateDueDateCptnLbl: Label 'Due Date';
        ILEEndDateDocNoCptnLbl: Label 'Document No.';
        ILEEndDatePstngDateCptnLbl: Label 'Posting Date';
        ILEEndDateDocTypeCptnLbl: Label 'Document Type';
        TotalQtyCptnLbl: Label 'Total Quantity';
        EnterDateFormulaErr: Label 'Enter a date formula in the Period Length field.';
        CompanyDisplayName: Text;
        TelemetryCategoryTxt: Label 'Report', Locked = true;
        AgedARReportGeneratedTxt: Label 'Aged AR Report generated.', Locked = true;

    protected var
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        NumberOfLines: Integer;
        StartDateTime: DateTime;
        FinishDateTime: DateTime;
        ItemFilter: Text;
        PrintDetails: Boolean;

}
