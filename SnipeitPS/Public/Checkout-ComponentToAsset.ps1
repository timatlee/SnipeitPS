<#
.SYNOPSIS
Checks out a component to an asset

.DESCRIPTION
Checks out a component to an asset

.PARAMETER id
An id of a specific component

.PARAMETER assigned_to
ID of asset

.PARAMETER assigned_qty
Quantity assigned. Defaults to 1.

.EXAMPLE
Checkout-ComponentToAsset -id 1 -assigned_to 3 -assigned_qty 1
#>

function Checkout-ComponentToAsset() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [int]$id,

        [parameter(mandatory = $true)]
        [int]$assigned_to,

        [parameter(mandatory = $false)]
        [int]$assigned_qty = 1
    )
    begin {
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

        if ($Values['purchase_date']) {
            $Values['purchase_date'] = $Values['purchase_date'].ToString("yyyy-MM-dd")
        }

        $Parameters = @{
            Api    = "/api/v1/components/$($id)/checkout"
            Method = 'POST'
            Body   = $Values
        }
    }

    process {
        if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
            $result = Invoke-SnipeitMethod @Parameters
        }

        $result
    }

    end {}
}

