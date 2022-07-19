<#
.Synopsis
   Finds the vendor from a given MAC Address
.DESCRIPTION
   Uses the api.macvendors.com to find the vendor of the supplied MAC Address so you will require internet connection for this function to run smoothly
.EXAMPLE
   Get-MacAddressVendor -MacAddress E0-9D-31-18-B5-7C
.EXAMPLE 
   "E0-9D-31-18-B5-7C" | Get-MacAddressVendor
#>
function Get-MacAddressVendor
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                  ValueFromPipeline=$true,
                   Position=0)]
         [ValidatePattern('^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$')]
        $MacAddress
    )

    Begin
    {
 
    }
    Process
    {
Foreach ($Address in $MacAddress){
   try
   {
       Write-Host -ForegroundColor Yellow "Processing $Address to find the vendor"
       Invoke-WebRequest -UseBasicParsing -Uri "https://api.macvendors.com/$Address" -Method GET | select -ExpandProperty Content -ErrorAction Stop
   }
   catch 
   {
       $bad = $_
       Write-Warning "Crumbs something went wrong $bad"  
   }
}      
    }
    End
    {
    }
}