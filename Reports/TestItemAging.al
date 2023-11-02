report 50003 AgedTest1
{

    DefaultLayout = RDLC;
    RDLCLayout = 'ItemAgingReport.rdl';
    Caption = 'Item Aging Reports test';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DataAccessIntent = ReadOnly;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemTableView = SORTING("Item No.", "Posting Date");
                PrintOnlyIfDetail = true;
                DataItemLink = "Item No." = field("No.");

                column(HeaderText5; HeaderText[5])
                {
                }
                column(HeaderText4; HeaderText[4])
                {
                }
                column(HeaderText3; HeaderText[3])
                {
                }
                column(HeaderText2; HeaderText[2])
                {
                }
                column(HeaderText1; HeaderText[1])
                {
                }
                column(CompanyName; CompanyDisplayName)
                {
                }
                column(ItemAgingReportCptn; ItemAgingReportCptnLbl)
                {
                }
                column(TotalQtyCptn; TotalQtyCptnLbl)
                {
                }
                column(Name1_Item; "Item Ledger Entry".Description)
                {
                    IncludeCaption = true;
                }
                column(No_Item; "Item Ledger Entry"."Item No.")
                {
                    IncludeCaption = true;
                }
                column(AgedILE1RemQty; AgedItemLedgEntry[1]."Remaining Quantity")
                {
                    AutoFormatType = 1;
                }
                column(AgedILE2RemQty; AgedItemLedgEntry[2]."Remaining Quantity")
                {
                    AutoFormatType = 1;
                }
                column(AgedILE3RemQty; AgedItemLedgEntry[3]."Remaining Quantity")
                {
                    AutoFormatType = 1;
                }
                column(AgedILE4RemQty; AgedItemLedgEntry[4]."Remaining Quantity")
                {
                    AutoFormatType = 1;
                }
                column(AgedILE5RemQty; AgedItemLedgEntry[5]."Remaining Quantity")
                {
                    AutoFormatType = 1;
                }

                column(TotalILE1RemQty; TotalItemLedgEntry[1]."Remaining Quantity")
                {
                    AutoFormatType = 1;
                }
                column(TotalILE2RemQty; TotalItemLedgEntry[2]."Remaining Quantity")
                {
                    AutoFormatType = 1;
                }
                column(TotalILE3RemQty; TotalItemLedgEntry[3]."Remaining Quantity")
                {
                    AutoFormatType = 1;
                }
                column(TotalILE4RemQty; TotalItemLedgEntry[4]."Remaining Quantity")
                {
                    AutoFormatType = 1;
                }
                column(TotalILE5RemQty; TotalItemLedgEntry[5]."Remaining Quantity")
                {
                    AutoFormatType = 1;
                }
                column(GrandTotalILE5RemQty; GrandTotalItemLedgEntry[5]."Remaining Quantity")
                {
                    AutoFormatType = 1;
                }
                column(GrandTotalILE4RemQty; GrandTotalItemLedgEntry[4]."Remaining Quantity")
                {
                    AutoFormatType = 1;
                }
                column(GrandTotalILE3RemQty; GrandTotalItemLedgEntry[3]."Remaining Quantity")
                {
                    AutoFormatType = 1;
                }
                column(GrandTotalILE2RemQty; GrandTotalItemLedgEntry[2]."Remaining Quantity")
                {
                    AutoFormatType = 1;
                }
                column(GrandTotalILE1RemQty; GrandTotalItemLedgEntry[1]."Remaining Quantity")
                {
                    AutoFormatType = 1;
                }

                trigger OnAfterGetRecord()
                var
                    PeriodIndex: Integer;
                    Item: Record Item;

                begin
                    Clear(TotalItemLedgEntry);
                    if Item.Get("Item No.") then;
                    // if Item.FindFirst() then
                    //     repeat begin
                    //         ItemLedgEntryEndingDate.SetRange("Item No.", Item."No.");
                    //         if ItemLedgEntryEndingDate.FindSet() then
                    //             repeat
                    //                 if ItemLedgEntryEndingDate."Posting Date" <= WorkDate() then begin
                    //                     PeriodIndex := GetPeriodIndex(ItemLedgEntryEndingDate."Posting Date");
                    //                     Clear(AgedItemLedgEntry);
                    //                     AgedItemLedgEntry[PeriodIndex]."Remaining Quantity" := ItemLedgEntryEndingDate."Remaining Quantity";
                    //                     TotalItemLedgEntry[PeriodIndex]."Remaining Quantity" += ItemLedgEntryEndingDate."Remaining Quantity";
                    //                     GrandTotalItemLedgEntry[PeriodIndex]."Remaining Quantity" += ItemLedgEntryEndingDate."Remaining Quantity";
                    //                     // TotalItemLedgEntry[1].Quantity += ItemLedgEntryEndingDate."Remaining Quantity";
                    //                     // GrandTotalItemLedgEntry[1].Quantity += ItemLedgEntryEndingDate."Remaining Quantity";
                    //                     NumberOfLines += 1;
                    //                 end;
                    //             until ItemLedgEntryEndingDate.Next() = 0;
                    //     end until Item.Next() = 0;



                end;



                // trigger OnPreDataItem()
                // begin
                //     SetRange("Posting Date", EndingDate + 1, DMY2Date(31, 12, 9999));
                // end;

            }

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
        ItemFilter := FormatDocument.GetRecordFiltersWithCaptions("Item Ledger Entry");

        // GLSetup.Get();

        CalcDates();
        CreateHeadings();

        PageGroupNo := 1;
        NextPageGroupNo := 1;
        // ItemFilterCheck := (ItemFilter <> 'No.');

        CompanyDisplayName := COMPANYPROPERTY.DisplayName();
    end;


    trigger OnPostReport()
    begin
        FinishDateTime := CurrentDateTime();
        LogReportTelemetry(StartDateTime, FinishDateTime, NumberOfLines);
    end;


    var


        ItemLedgEntryEndingDate: Record "Item Ledger Entry";
        TotalItemLedgEntry: array[5] of Record "Item Ledger Entry";
        GrandTotalItemLedgEntry: array[5] of Record "Item Ledger Entry";
        AgedItemLedgEntry: array[6] of Record "Item Ledger Entry";
        PeriodLength: DateFormula;
        EndingDate: Date;
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

    local procedure CalcDates()
    var
        PeriodLength2: DateFormula;
        i: Integer;
    begin
        if not Evaluate(PeriodLength2, StrSubstNo(Text032Txt, PeriodLength)) then
            Error(EnterDateFormulaErr);

        PeriodEndDate[1] := EndingDate;
        PeriodStartDate[1] := CalcDate(PeriodLength2, EndingDate + 1);

        for i := 2 to ArrayLen(PeriodEndDate) do begin
            PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
            PeriodStartDate[i] := CalcDate(PeriodLength2, PeriodEndDate[i] + 1);
        end;
        PeriodStartDate[i] := 0D;

        for i := 1 to ArrayLen(PeriodEndDate) do
            if PeriodEndDate[i] < PeriodStartDate[i] then
                Error(Text010, PeriodLength);
    end;

    local procedure CreateHeadings()
    var
        i: Integer;
    begin

        i := 1;
        while i < ArrayLen(PeriodEndDate) do begin
            if HeadingType = HeadingType::"Date Interval" then
                HeaderText[i] := StrSubstNo('%1\..%2', PeriodStartDate[i], PeriodEndDate[i])
            else
                HeaderText[i] :=
                  StrSubstNo('%1 - %2 %3', EndingDate - PeriodEndDate[i] + 1, EndingDate - PeriodStartDate[i] + 1, Text002);
            i := i + 1;
        end;
        if HeadingType = HeadingType::"Date Interval" then
            HeaderText[i] := StrSubstNo('%1 %2', BeforeTok, PeriodStartDate[i - 1])
        else
            HeaderText[i] := StrSubstNo('%1 %2 %3', AfterTok, EndingDate - PeriodStartDate[i - 1] + 1, Text002);
    end;

    local procedure GetPeriodIndex(Date: Date): Integer
    var
        i: Integer;
    begin
        for i := 1 to ArrayLen(PeriodEndDate) do
            if Date in [PeriodStartDate[i] .. PeriodEndDate[i]] then
                exit(i);
    end;


    local procedure LogReportTelemetry(StartDateTime: DateTime; FinishDateTime: DateTime; NumberOfLines: Integer)
    var
        Dimensions: Dictionary of [Text, Text];
        ReportDuration: BigInteger;
    begin
        ReportDuration := FinishDateTime - StartDateTime;
        Dimensions.Add('Category', TelemetryCategoryTxt);
        Dimensions.Add('ReportStartTime', Format(StartDateTime, 0, 9));
        Dimensions.Add('ReportFinishTime', Format(FinishDateTime, 0, 9));
        Dimensions.Add('ReportDuration', Format(ReportDuration));
        Dimensions.Add('NumberOfLines', Format(NumberOfLines));
        Session.LogMessage('0000FJM', AgedARReportGeneratedTxt, Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, Dimensions);
    end;

}
