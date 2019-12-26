$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Convert-MilesToKilometers" {
    Context "no parameter entered" {
        It "should return a zero" {
            Convert-MilesToKilometers | Should BeExactly "0"
        }
    }
    Context "special character is entered" {
        It "fails" {
            { Convert-MilesToKilometers ~ } | Should Throw
        }
    }
    Context "string characters are entered" {
        It "fails" {
            { Convert-MilesToKilometers agl } | Should Throw
        }
    }
    Context "a positive int32 is entered" {
        It "returns a correct solution: 4.82802" {
            Convert-MilesToKilometers 3 | Should Be "4.82802"
        }
    }
    Context "a negative int32 is entered" {
        It "ignores the sign and returns the correct solution: 159.32466" {
            Convert-MilesToKilometers -99 | Should Be "159.32466"
        }
    }
    Context "a zero is entered" {
        It "returns a zero" {
            Convert-MilesToKilometers 0 | Should Be "0"
        }
    }
    Context "a boolean true is entered" {
        It "returns 1.60934 (as if a 1 was entered)" {
            Convert-MilesToKilometers $true | Should Be "1.60934"
        }
    }
    Context "multiple parameter values are entered" {
        It "fails" {
            { Convert-MilesToKilometers 2 alpha } | Should Throw
        }
    }
}
Describe "Convert-FahrenheitToCelcius" {
    Context "no parameter entered" {
        It "should return a result: -17.78" {
            Convert-FahrenheitToCelcius | Should BeExactly "-17.78"
        }
    }
    Context "special character is entered" {
        It "fails" {
            { Convert-FahrenheitToCelcius ~ } | Should Throw
        }
    }
    Context "string characters are entered" {
        It "fails" {
            { Convert-FahrenheitToCelcius agl } | Should Throw
        }
    }
    Context "a positive int32 is entered" {
        It "returns a correct solution: -16.11" {
            Convert-FahrenheitToCelcius 3 | Should Be "-16.11"
        }
    }
    Context "a negative int32 is entered" {
        It "ignores the sign and returns the correct solution: -72.78" {
            Convert-FahrenheitToCelcius -99 | Should Be "-72.78"
        }
    }
    Context "a zero is entered" {
        It "returns a -17.78" {
            Convert-FahrenheitToCelcius 0 | Should Be "-17.78"
        }
    }
    Context "a boolean true is entered" {
        It "returns -17.22 (as if a 1 was entered)" {
            Convert-FahrenheitToCelcius $true | Should Be "-17.22"
        }
    }
    Context "multiple parameter values are entered" {
        It "fails" {
            { Convert-FahrenheitToCelcius 2 alpha } | Should Throw
        }
    }
}
Describe "Round-Number" {
    Context "No paramter entered" {
        It "assume zeros entered so return 0 rounded to 0 characters" {
            Round-Number | Should BeExactly "0"
        }
    }
    Context "special characters are entered" {
        It "should fail since math requires numbers" {
            { Round-Number % * } | Should Throw
        }
    }
    Context "string characters are entered" {
        It "should fail since math requires numbers" {
            { Round-Number z charlie } | Should Throw
        }
    }
    Context "positive double and a negative int16 equivalent are entered" {
        It "should assume the round_to param is always positive and rounded output 123.46" {
            Round-Number 123.45678 -2 | Should BeExactly "123.46"
        }
    }
    Context "negative double and a negative int16 are entered" {
        It "should not change input_value and should change round_to to a positive number, returning -123.46" {
            Round-Number -123.45678 -3 | Should BeExactly "-123.457"
        }
    }
    Context "a zero and a zero are entered" {
        It "returns a 0 rounded to 0 characters; 0" {
            Round-Number 0 0 | Should BeExactly "0"
        }
    }
    Context "a boolean true is entered as the input_value" {
        It "should assume true=1; round_to wouldn't change the output of 1" {
            Round-Number $true 3 | Should BeExactly "1"
        }
    }
    Context "a boolean true and boolean false are used as parameters" {
        It "should convert true=1 and false=0 and return a 1" {
            Round-Number $true $false | Should BeExactly "1"
        }
    }
    Context "too many parameters are entered" {
        It "fails" {
            { Round-Number 123.456 2 17.2839 3 } | Should Throw
        }
    }
    Context "outside bounds input_value; inside bounds round_to value" {
        It "fails" {
            { Round-Number 1.79769313486233E+308 10 } | Should Throw
        }
    }
    Context "inside bounds input_value; outside bounds (actually a uint16) round_to value" {
        It "fails" {
            { Round-Number 2147483647 655535 } | Should Throw
        }
    }
}