	IDENTIFICATION DIVISION.
	PROGRAM-ID. COBOL_exer1.
    AUTHOR. Ivyann Romijn Vergara


	ENVIRONMENT DIVISION.

	DATA DIVISION.
		WORKING-STORAGE SECTION.
		77 EXITED PIC 9 VALUE 0.
		77 CHOICE PIC 9.

*> Variables used for incrementing
        77 I PIC 9.
        77 J PIC 9.
        77 M PIC 9.

*> Variables used as temp value
        77 A PIC 9.
        77 MaxEven PIC 9.
        77 TEMPNO PIC 9.
        77 DupCount PIC 9.

*> For palindrome check
        77 PalCheck PIC 9.
*> Array 
        01 ARRAY1.
            02 element occurs 7 times PIC 9 .

	PROCEDURE DIVISION.
		PERFORM PMENU UNTIL EXITED = 1.
        STOP RUN.
		PMENU.

		DISPLAY " MENU ".
		DISPLAY "[1] Fill Array ".
		DISPLAY "[2] Print Array ".
        DISPLAY "[3] Find the Duplicate ".
        DISPLAY "[4] Largest Even Number ".
        DISPLAY "[5] Palindrome Checker ".
        DISPLAY "[6] Exit ".
		DISPLAY " Choice : " WITH NO ADVANCING .

		ACCEPT CHOICE.

		IF CHOICE = 1
			PERFORM FILLARRAY.

        IF CHOICE = 2
            PERFORM PRINTARRAY.

        IF CHOICE = 3
			PERFORM FINDDUPLICATE.

        IF CHOICE = 4
            PERFORM LARGESTEVEN.

        IF CHOICE = 5
		    PERFORM PALINDROMECHECK.

        IF CHOICE = 6
            DISPLAY "GOODBYE!"
            MOVE 1 TO EXITED
		ELSE
			DISPLAY "INVALID INPUT!"
		END-IF.

*> Gets the user input and then moves it into the appropriate index, it overwrite the TEMPNO variable
        FILLARRAY.
        DISPLAY "FILL ARRAY"
            ACCEPT TEMPNO
            MOVE TEMPNO TO element(1)
            ACCEPT TEMPNO
            MOVE TEMPNO TO element(2)
            ACCEPT TEMPNO
            MOVE TEMPNO TO element(3)
            ACCEPT TEMPNO
            MOVE TEMPNO TO element(4)
            ACCEPT TEMPNO
            MOVE TEMPNO TO element(5)
            ACCEPT TEMPNO
            MOVE TEMPNO TO element(6)
            ACCEPT TEMPNO
            MOVE TEMPNO TO element(7)
            PERFORM PMENU.
            EXIT PARAGRAPH.

*> Prints all the values of the array using a loop. Added an extra line for aesthetic purpose
        PRINTARRAY.
        PERFORM VARYING J FROM 1 BY 1 UNTIL J>8
                DISPLAY "   " element(J) WITH NO ADVANCING
        END-PERFORM
        DISPLAY "   "
        PERFORM PMENU.

*> Finds the duplicate in the array. Iterates through the array first by a nested loop then compares it if it is the same 
*> If it is the same, it prints the element
        FINDDUPLICATE.
        DISPLAY "FIND DUPLICATE".
        PERFORM VARYING I FROM 1 BY 1 UNTIL I>7
            PERFORM VARYING J FROM 1 BY 1 UNTIL J>(I - 1)
                IF element(I) = element(J)
                    COMPUTE DupCount= DupCount + 1
                    IF DupCount > 2
                        DISPLAY " " element(J)
                    ELSE 
                        DISPLAY " " element(J)
                    END-IF
                END-IF
            END-PERFORM
        END-PERFORM
        PERFORM PMENU.

*> Checks if it is even number by the modulo function. Then stores the element in a temporary variable (A)
*> Compares each variable if it is the max even. Then it frees the variable (so the function can be used repeatedly)
        LARGESTEVEN.
        DISPLAY "LARGEST EVEN NUMBER".
        PERFORM VARYING I FROM 1 BY 1 UNTIL I>7
            COMPUTE M = Function Mod (element(I), 2) *> Modulo Function
            IF M EQUAL TO 0 THEN   *> If it doesn't have a remainder then it is even 
                MOVE element(I) to A
                IF A > MaxEven
                    MOVE A to MaxEven
                ELSE
                    CONTINUE *>If it is lower than the current MaxEven, it just passes through
                END-IF
            ELSE
                CONTINUE *> If it is odd, it is just ignored
            END-IF
        END-PERFORM   
        DISPLAY MaxEven
        MOVE 0 to MaxEven
        PERFORM PMENU.

*> Checks if the array is a palindrome, reverses it then checks if it is equal
        PALINDROMECHECK.
        DISPLAY "PALINDROME CHECKER"
        IF ARRAY1 = function reverse(ARRAY1) THEN
            DISPLAY 'ARRAY ELEMENTS ARE PALINDROME!'
        ELSE
            DISPLAY "ARRAY ELEMENTS ARE NOT PALINDROME!"
        END-IF
        PERFORM PMENU.

*> REFERENCES
*> For Palindrome Function : https://www.ibm.com/docs/en/developer-for-zos/9.1.1?topic=functions-reverse
*> For Module : https://www.ibm.com/docs/en/iis/11.5?topic=programming-mod-function
