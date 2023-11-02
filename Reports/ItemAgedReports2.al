// report 50001 "Aged2"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = 'ItemAgingReport2.rdl';
//     Caption = 'Item Aging Reports';
//     ApplicationArea = All;
//     UsageCategory = ReportsAndAnalysis;
//     DataAccessIntent = ReadOnly;

//     dataset
//     {
//         dataitem(Header; "Integer")
//         {
//             DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
//             column(PageGroupNo; PageGroupNo)
//             {
//             }
//             column(CompanyName; CompanyDisplayName)
//             {
//             }
//             column(FormatEndingDate; StrSubstNo(Text006, Format(EndingDate, 0, 4)))
//             {
//             }
//             column(PostingDate; StrSubstNo(Text007, SelectStr(AgingBy + 1, Text009)))
//             {
//             }
//             column(PrintItemQty; PrintItemQty)
//             {
//             }
//             column(TableCaptnItemFilter; Item.TableCaption + ': ' + ItemFilter)
//             {
//             }
//             column(ItemFilter; ItemFilter)
//             {
//             }

//             column(AgedbyDocumnetDate; StrSubstNo(Text004, SelectStr(AgingBy + 1, Text009)))
//             {
//             }
//             column(HeaderText5; HeaderText[5])
//             {
//             }
//             column(HeaderText4; HeaderText[4])
//             {
//             }
//             column(HeaderText3; HeaderText[3])
//             {
//             }
//             column(HeaderText2; HeaderText[2])
//             {
//             }
//             column(HeaderText1; HeaderText[1])
//             {
//             }
//             column(PrintDetails; PrintDetails)
//             {
//             }
//             column(ItemAgingReportCptn; ItemAgingReportCptnLbl)
//             {
//             }
//             column(CurrReportPageNoCptn; CurrReportPageNoCptnLbl)
//             {
//             }
//             column(AllQtyCptn; AllQtyCptnLbl)
//             {
//             }
//             column(ItemAgedQtyCptn; ItemAgedQtyCptnLbl)
//             {
//             }
//             column(ILEEndDateQtyCptn; ILEEndDateQtyCptnLbl)
//             {
//             }
//             column(ILEEndDateDueDateCptn; ILEEndDateDueDateCptnLbl)
//             {
//             }
//             column(ILEEndDateDocNoCptn; ILEEndDateDocNoCptnLbl)
//             {
//             }
//             column(ILEEndDatePstngDateCptn; ILEEndDatePstngDateCptnLbl)
//             {
//             }
//             column(ILEEndDateDocTypeCptn; ILEEndDateDocTypeCptnLbl)
//             {
//             }

//             column(TotalQtyCptn; TotalQtyCptnLbl)
//             {
//             }
//             column(NewPagePerItem; NewPagePerItem)
//             {
//             }
//             column(GrandTotalILE5RemQty; GrandTotalItemLedgEntry[5]."Remaining Quantity")
//             {
//                 AutoFormatType = 1;
//             }
//             column(GrandTotalILE4RemQty; GrandTotalItemLedgEntry[4]."Remaining Quantity")
//             {
//                 AutoFormatType = 1;
//             }
//             column(GrandTotalILE3RemQty; GrandTotalItemLedgEntry[3]."Remaining Quantity")
//             {
//                 AutoFormatType = 1;
//             }
//             column(GrandTotalILE2RemQty; GrandTotalItemLedgEntry[2]."Remaining Quantity")
//             {
//                 AutoFormatType = 1;
//             }
//             column(GrandTotalILE1RemQty; GrandTotalItemLedgEntry[1]."Remaining Quantity")
//             {
//                 AutoFormatType = 1;
//             }
//             column(GrandTotalILEQty; GrandTotalItemLedgEntry[1].Quantity)
//             {
//                 AutoFormatType = 1;
//             }

//             column(GrandTotalILE1Qty; GrandTotalItemLedgEntry[1].Quantity)
//             {
//                 AutoFormatType = 1;
//             }

//             dataitem(Item; Item)
//             {
//                 RequestFilterFields = "No.";


//                 dataitem("Item Ledger Entry"; "Item Ledger Entry")
//                 {
//                     DataItemLink = "Item No." = FIELD("No.");
//                     DataItemTableView = SORTING("Item No.", "Posting Date");


//                     trigger OnPreDataItem()
//                     begin
//                         SetRange("Posting Date", EndingDate + 1, DMY2Date(31, 12, 9999));
//                     end;
//                 }


//                 dataitem(OpenItemLedgEntry; "Item Ledger Entry")
//                 {
//                     DataItemLink = "Item No." = FIELD("No.");
//                     DataItemTableView = SORTING("Item No.", "Posting Date");
//                     trigger OnAfterGetRecord()
//                     begin
//                         InsertTemp(OpenItemLedgEntry);
//                         CurrReport.Skip();
//                     end;

//                     trigger OnPreDataItem()
//                     begin
//                         if AgingBy = AgingBy::"Posting Date" then begin
//                             SetRange("Posting Date", 0D, EndingDate);
//                         end;

//                     end;
//                 }
//                 dataitem(CurrencyLoop; "Integer")
//                 {
//                     DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
//                     PrintOnlyIfDetail = true;
//                     dataitem(TempCustLedgEntryLoop; "Integer")
//                     {
//                         DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
//                         // column(Document_No_; "Document No.")
//                         // {

//                         // }
//                         // column(Posting_Date; "Posting Date")
//                         // {

//                         // }
//                         // column(Item_No_; Item."No.")
//                         // {

//                         // }
//                         // // column(ItemDescription; )
//                         // // {

//                         // // }

//                         column(Name1_Item; Item.Description)
//                         {
//                             IncludeCaption = true;
//                         }
//                         column(No_Item; Item."No.")
//                         {
//                             IncludeCaption = true;
//                         }
//                         column(ILEEndDateRemQty; ItemLedgEntryEndingDate."Remaining Quantity")
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(AgedILE1RemQty; AgedItemLedgEntry[1]."Remaining Quantity")
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(AgedILE2RemQty; AgedItemLedgEntry[2]."Remaining Quantity")
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(AgedILE3RemQty; AgedItemLedgEntry[3]."Remaining Quantity")
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(AgedILE4RemQty; AgedItemLedgEntry[4]."Remaining Quantity")
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(AgedILE5RemQty; AgedItemLedgEntry[5]."Remaining Quantity")
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(ILEEndDateQty; ItemLedgEntryEndingDate.Quantity)
//                         {
//                             AutoFormatType = 1;
//                         }

//                         column(ILEEndDateDocNo; ItemLedgEntryEndingDate."Document No.")
//                         {
//                         }
//                         column(ILEDocType; Format(ItemLedgEntryEndingDate."Document Type"))
//                         {
//                         }
//                         column(ILEPostingDate; Format(ItemLedgEntryEndingDate."Posting Date"))
//                         {
//                         }
//                         column(ILEEndDate_ExtDocNo; ItemLedgEntryEndingDate."External Document No.")
//                         {
//                         }
//                         column(TotalILE1Qty; TotalItemLedgEntry[1].Quantity)
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(TotalILE1RemQty; TotalItemLedgEntry[1]."Remaining Quantity")
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(TotalILE2RemQty; TotalItemLedgEntry[2]."Remaining Quantity")
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(TotalILE3RemQty; TotalItemLedgEntry[3]."Remaining Quantity")
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(TotalILE4RemQty; TotalItemLedgEntry[4]."Remaining Quantity")
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(TotalILE5RemQty; TotalItemLedgEntry[5]."Remaining Quantity")
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(TotalCheck; ItemFilterCheck)
//                         {
//                         }

//                         trigger OnAfterGetRecord()
//                         var
//                             PeriodIndex: Integer;
//                         begin

//                             if Number = 1 then begin
//                                 if not TempItemLedgEntry.FindSet(false, false) then
//                                     CurrReport.Break();
//                             end else
//                                 if TempItemLedgEntry.Next() = 0 then
//                                     CurrReport.Break();

//                             ItemLedgEntryEndingDate := TempItemLedgEntry;
//                             PhsInventLedgerEntry.SetRange("Entry No.", ItemLedgEntryEndingDate."Entry No.");
//                             if PhsInventLedgerEntry.FindSet(false, false) then
//                                 repeat
//                                     if (PhsInventLedgerEntry."Entry Type" =
//                                         PhsInventLedgerEntry."Entry Type"::Sale) and
//                                        (ItemLedgEntryEndingDate."Posting Date" > WorkDate()) and
//                                        (AgingBy <> AgingBy::"Posting Date")
//                                     then
//                                         if ItemLedgEntryEndingDate."Document Date" <= WorkDate() then
//                                             PhsInventLedgerEntry."Posting Date" :=
//                                               ItemLedgEntryEndingDate."Document Date"
//                                         else


//                                             if (PhsInventLedgerEntry."Posting Date" <= WorkDate()) or
//                                                (TempItemLedgEntry.Open and
//                                                 (ItemLedgEntryEndingDate."Posting Date" <= WorkDate()))
//                                             then begin
//                                                 if PhsInventLedgerEntry."Entry Type" in
//                                                    [PhsInventLedgerEntry."Entry Type"::Sale,
//                                                     PhsInventLedgerEntry."Entry Type"::Transfer,
//                                                     PhsInventLedgerEntry."Entry Type"::Purchase,
//                                                     PhsInventLedgerEntry."Entry Type"::"Positive Adjmt.",
//                                                     PhsInventLedgerEntry."Entry Type"::Output,
//                                                     PhsInventLedgerEntry."Entry Type"::"Negative Adjmt.",
//                                                     PhsInventLedgerEntry."Entry Type"::Consumption,
//                                                     PhsInventLedgerEntry."Entry Type"::"Assembly Output",
//                                                     PhsInventLedgerEntry."Entry Type"::"Assembly Consumption"]
//                                                 then begin
//                                                     ItemLedgEntryEndingDate.Quantity := ItemLedgEntryEndingDate.Quantity + PhsInventLedgerEntry.Quantity;
//                                                 end;
//                                                 if PhsInventLedgerEntry."Posting Date" <= WorkDate() then begin
//                                                     ItemLedgEntryEndingDate."Remaining Quantity" :=
//                                                       ItemLedgEntryEndingDate."Remaining Quantity" + PhsInventLedgerEntry.Amount;
//                                                 end;
//                                             end;
//                                 until PhsInventLedgerEntry.Next() = 0;

//                             if ItemLedgEntryEndingDate."Remaining Quantity" = 0 then
//                                 CurrReport.Skip();

//                             case AgingBy of
//                                 AgingBy::"Posting Date":
//                                     PeriodIndex := GetPeriodIndex(ItemLedgEntryEndingDate."Posting Date");
//                             end;
//                             Clear(AgedItemLedgEntry);
//                             AgedItemLedgEntry[PeriodIndex]."Remaining Quantity" := ItemLedgEntryEndingDate."Remaining Quantity";
//                             TotalItemLedgEntry[PeriodIndex]."Remaining Quantity" += ItemLedgEntryEndingDate."Remaining Quantity";
//                             GrandTotalItemLedgEntry[PeriodIndex]."Remaining Quantity" += ItemLedgEntryEndingDate."Remaining Quantity";
//                             TotalItemLedgEntry[1].Quantity += ItemLedgEntryEndingDate."Remaining Quantity";
//                             GrandTotalItemLedgEntry[1].Quantity += ItemLedgEntryEndingDate."Remaining Quantity";
//                             NumberOfLines += 1;
//                         end;

//                         trigger OnPreDataItem()
//                         begin
//                             // if not PrintItemQty then
//                             //     TempItemLedgEntry.SetRange("Entry No.", "Item Ledger Entry"."Entry No.");

//                             // TempItemLedgEntry.SetRange("Entry No.", OpenItemLedgEntry."Entry No.");
//                         end;
//                     }

//                     trigger OnAfterGetRecord()
//                     begin
//                         Clear(TotalItemLedgEntry);

//                         // if Number = 1 then begin
//                         //     if not TempCurrency.FindSet(false, false) then begin
//                         //         CurrReport.Break();
//                         //         NumberOfLines -= 1;
//                         //     end;
//                         // end else
//                         //     if TempCurrency.Next() = 0 then begin
//                         //         CurrReport.Break();
//                         //         NumberOfLines -= 1;
//                         //     end;
//                     end;



//                 }
//                 trigger OnAfterGetRecord()
//                 begin
//                     if NewPagePerItem then
//                         PageGroupNo += 1;
//                     // TempCurrency.Reset();
//                     // TempCurrency.DeleteAll();
//                     TempItemLedgEntry.Reset();
//                     TempItemLedgEntry.DeleteAll();
//                     NumberOfLines += 1;
//                 end;
//             }
//         }

//     }

//     requestpage
//     {
//         SaveValues = true;

//         layout
//         {
//             area(content)
//             {
//                 group(Options)
//                 {
//                     Caption = 'Options';
//                     field(AgedAsOf; EndingDate)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Aged As Of';
//                         ToolTip = 'Specifies the date that you want the aging calculated for.';
//                     }
//                     field(Agingby; AgingBy)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Aging by';
//                         OptionCaption = 'Posting Date';
//                         ToolTip = 'Specifies if the aging will be calculated from the due date, the posting date, or the document date.';
//                     }
//                     field(PeriodLength; PeriodLength)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Period Length';
//                         ToolTip = 'Specifies the period for which data is shown in the report. For example, enter "1M" for one month, "30D" for thirty days, "3Q" for three quarters, or "5Y" for five years.';
//                     }
//                     field(HeadingType; HeadingType)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Heading Type';
//                         OptionCaption = 'Date Interval,Number of Days';
//                         ToolTip = 'Specifies if the column heading for the three periods will indicate a date interval or the number of days overdue.';
//                     }
//                 }
//             }
//         }

//         actions
//         {
//         }

//         trigger OnOpenPage()
//         begin
//             if EndingDate = 0D then
//                 EndingDate := WorkDate();
//             if Format(PeriodLength) = '' then
//                 Evaluate(PeriodLength, '<1M>');
//         end;
//     }

//     labels
//     {
//         BalanceCaption = 'Balance';
//     }

//     trigger OnPreReport()
//     var
//         FormatDocument: Codeunit "Format Document";
//     begin
//         StartDateTime := CurrentDateTime();
//         ItemFilter := FormatDocument.GetRecordFiltersWithCaptions(Item);

//         GLSetup.Get();

//         CalcDates();
//         CreateHeadings();

//         PageGroupNo := 1;
//         NextPageGroupNo := 1;
//         ItemFilterCheck := (ItemFilter <> 'No.');

//         CompanyDisplayName := COMPANYPROPERTY.DisplayName();
//     end;

//     trigger OnPostReport()
//     begin
//         FinishDateTime := CurrentDateTime();
//         LogReportTelemetry(StartDateTime, FinishDateTime, NumberOfLines);
//     end;

//     var
//         GLSetup: Record "General Ledger Setup";
//         PhsInventLedgerEntry: Record "Phys. Inventory Ledger Entry";
//         ItemLedgEntryEndingDate: Record "Item Ledger Entry";
//         TotalItemLedgEntry: array[5] of Record "Item Ledger Entry";
//         GrandTotalItemLedgEntry: array[5] of Record "Item Ledger Entry";
//         AgedItemLedgEntry: array[6] of Record "Item Ledger Entry";
//         TempCurrency: Record Currency temporary;
//         TempCurrency2: Record Currency temporary;
//         TempCurrencyAmount: Record "Currency Amount" temporary;
//         PeriodLength: DateFormula;
//         PrintItemQty: Boolean;
//         EndingDate: Date;
//         AgingBy: Option "Posting Date";
//         HeadingType: Option "Date Interval","Number of Days";
//         NewPagePerItem: Boolean;
//         PeriodStartDate: array[5] of Date;
//         PeriodEndDate: array[5] of Date;
//         HeaderText: array[5] of Text[30];
//         Text000: Label 'Not Due';
//         AfterTok: Label 'After';
//         BeforeTok: Label 'Before';
//         CurrencyCode: Code[10];
//         Text002: Label 'days';
//         Text004: Label 'Aged by %1';
//         Text005: Label 'Total for %1';
//         Text006: Label 'Aged as of %1';
//         Text007: Label 'Aged by %1';
//         NumberOfCurrencies: Integer;
//         Text009: Label 'Due Date,Posting Date,Document Date';
//         Text010: Label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.';
//         PageGroupNo: Integer;
//         NextPageGroupNo: Integer;
//         ItemFilterCheck: Boolean;
//         Text032Txt: Label '-%1', Comment = 'Negating the period length: %1 is the period length';
//         ItemAgingReportCptnLbl: Label 'Item Aging Report';
//         CurrReportPageNoCptnLbl: Label 'Page';
//         AllQtyCptnLbl: Label 'All Quantity in Inventory';
//         ItemAgedQtyCptnLbl: Label 'Item Aged Quantity';
//         ILEEndDateQtyCptnLbl: Label 'Original Quantity ';
//         ILEEndDateDueDateCptnLbl: Label 'Due Date';
//         ILEEndDateDocNoCptnLbl: Label 'Document No.';
//         ILEEndDatePstngDateCptnLbl: Label 'Posting Date';
//         ILEEndDateDocTypeCptnLbl: Label 'Document Type';
//         TotalQtyCptnLbl: Label 'Total Quantity';
//         EnterDateFormulaErr: Label 'Enter a date formula in the Period Length field.';
//         CompanyDisplayName: Text;
//         TelemetryCategoryTxt: Label 'Report', Locked = true;
//         AgedARReportGeneratedTxt: Label 'Aged AR Report generated.', Locked = true;

//     protected var
//         TempItemLedgEntry: Record "Item Ledger Entry" temporary;
//         NumberOfLines: Integer;
//         StartDateTime: DateTime;
//         FinishDateTime: DateTime;
//         ItemFilter: Text;
//         PrintDetails: Boolean;

//     local procedure CalcDates()
//     var
//         PeriodLength2: DateFormula;
//         i: Integer;
//     begin
//         if not Evaluate(PeriodLength2, StrSubstNo(Text032Txt, PeriodLength)) then
//             Error(EnterDateFormulaErr);

//         PeriodEndDate[1] := EndingDate;
//         PeriodStartDate[1] := CalcDate(PeriodLength2, EndingDate + 1);

//         for i := 2 to ArrayLen(PeriodEndDate) do begin
//             PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
//             PeriodStartDate[i] := CalcDate(PeriodLength2, PeriodEndDate[i] + 1);
//         end;
//         PeriodStartDate[i] := 0D;

//         for i := 1 to ArrayLen(PeriodEndDate) do
//             if PeriodEndDate[i] < PeriodStartDate[i] then
//                 Error(Text010, PeriodLength);
//     end;

//     local procedure CreateHeadings()
//     var
//         i: Integer;
//     begin

//         i := 1;
//         while i < ArrayLen(PeriodEndDate) do begin
//             if HeadingType = HeadingType::"Date Interval" then
//                 HeaderText[i] := StrSubstNo('%1\..%2', PeriodStartDate[i], PeriodEndDate[i])
//             else
//                 HeaderText[i] :=
//                   StrSubstNo('%1 - %2 %3', EndingDate - PeriodEndDate[i] + 1, EndingDate - PeriodStartDate[i] + 1, Text002);
//             i := i + 1;
//         end;
//         if HeadingType = HeadingType::"Date Interval" then
//             HeaderText[i] := StrSubstNo('%1 %2', BeforeTok, PeriodStartDate[i - 1])
//         else
//             HeaderText[i] := StrSubstNo('%1 %2 %3', AfterTok, EndingDate - PeriodStartDate[i - 1] + 1, Text002);
//     end;

//     local procedure InsertTemp(var ItemLedgEntry: Record "Item Ledger Entry")
//     var
//         Currency: Record Currency;
//     begin
//         if TempItemLedgEntry.Get(ItemLedgEntry."Entry No.") then
//             exit;
//         TempItemLedgEntry.Init();
//         TempItemLedgEntry := ItemLedgEntry;
//         TempItemLedgEntry.Insert();


//     end;

//     local procedure GetPeriodIndex(Date: Date): Integer
//     var
//         i: Integer;
//     begin
//         for i := 1 to ArrayLen(PeriodEndDate) do
//             if Date in [PeriodStartDate[i] .. PeriodEndDate[i]] then
//                 exit(i);
//     end;


//     local procedure LogReportTelemetry(StartDateTime: DateTime; FinishDateTime: DateTime; NumberOfLines: Integer)
//     var
//         Dimensions: Dictionary of [Text, Text];
//         ReportDuration: BigInteger;
//     begin
//         ReportDuration := FinishDateTime - StartDateTime;
//         Dimensions.Add('Category', TelemetryCategoryTxt);
//         Dimensions.Add('ReportStartTime', Format(StartDateTime, 0, 9));
//         Dimensions.Add('ReportFinishTime', Format(FinishDateTime, 0, 9));
//         Dimensions.Add('ReportDuration', Format(ReportDuration));
//         Dimensions.Add('NumberOfLines', Format(NumberOfLines));
//         Session.LogMessage('0000FJM', AgedARReportGeneratedTxt, Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, Dimensions);
//     end;



// }

