Attribute VB_Name = "StockMkt"
Sub StockMkt()

For Each ws In Worksheets

    ws.Range("I1") = "Ticker"
    ws.Range("J1") = "Yearly Change"
    ws.Range("K1") = "Percent Change"
    ws.Range("L1") = "Total Stock Volume"
    

    Dim ticker As String
    Dim volume As Double
    Dim yearchange As Double
    Dim percentchange As Double
    Dim yearopen As Double
    Dim yearclose As Double
            
    lastrow = ws.Cells(Rows.Count, 1).End(xlUp).Row

    volume = 0

    Dim summary_table_row As Double
    summary_table_row = 2

'ticker and totalstockvolume, wouldnt work with totalstockvolume, tried just volume and it worked

    For i = 2 To lastrow

         If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1) Then
            ticker = ws.Cells(i, 1).Value
            volume = volume + ws.Cells(i, 7).Value

            ws.Range("I" & summary_table_row).Value = ticker
            ws.Range("L" & summary_table_row).Value = volume

            volume = 0
            
'now add year change and percent change, format to percent!(.style and .numberformat)
    
    yearclose = ws.Cells(i, 6)
            
            If yearopen = 0 Then
                yearchange = 0
                percentchange = 0
            Else:
                yearchange = yearclose - yearopen
                percentchange = (yearclose - yearopen) / yearopen
            End If
                          
                ws.Range("J" & summary_table_row).Value = yearchange
                ws.Range("K" & summary_table_row).Value = percentchange
                ws.Range("K" & summary_table_row).Style = "percent"
                ws.Range("K" & summary_table_row).NumberFormat = "0.00%"
            
            
    summary_table_row = summary_table_row + 1
            
            
ElseIf ws.Cells(i - 1, 1).Value <> Cells(i, 1) Then
    yearopen = ws.Cells(i, 3)
    
        Else: volume = volume + ws.Cells(i, 7).Value

End If

        Next i
        
'add conditional format to year change green(4) if positive(>0) red(3) if negative(-0)
    For i = 2 To lastrow
        If ws.Range("J" & i).Value > 0 Then
            ws.Range("J" & i).Interior.ColorIndex = 4
        ElseIf ws.Range("J" & i).Value < 0 Then
            ws.Range("J" & i).Interior.ColorIndex = 3
        End If
        
    Next i
    
' BONUS ADD "Greatest % increase", "Greatest % decrease" and "Greatest total volume"
        ws.Range("N1").Value = "GREATEST:"
        ws.Range("N2").Value = "% INCREASE"
        ws.Range("N3").Value = "% DECREASE"
        ws.Range("N4").Value = "TOTAL VOLUME"
        ws.Range("O1").Value = "Ticker"
        ws.Range("P1").Value = "Value"
    
 Dim maxincrease As Double
 Dim maxdecrease As Double
 
    maxincrease = Application.WorksheetFunction.Max(Columns("K"))
     'ws.Range("O1" & summary_table_row).Value = ticker
    'maxIT = Application.WorksheetFunction.Max(Columns("K"), ("A"))
    'maxIT = applicaation.WorksheetFunction.Lookup(Columns("A"))
    maxdecrease = Application.WorksheetFunction.Min(Columns("K"))
    maxvolume = Application.WorksheetFunction.Max(Columns("L"))
    
        ws.Range("P2").Value = maxincrease
        ws.Range("P3").Value = maxdecrease
        ws.Range("P2").Style = "percent"
        ws.Range("P3").Style = "percent"
        ws.Range("P4").Value = maxvolume
        ws.Range("O2").Value = maxIT
 
   'cant figure out how proudce the lookup of ticker value

Next ws

End Sub
