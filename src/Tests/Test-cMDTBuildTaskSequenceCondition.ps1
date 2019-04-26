#
# cMDTBuildTaskSequenceCondition Test
#
$PSDriveName = "MDT001"
$PSDrivePath = "E:\MDTBuildLab"
$TSID = "REFW10X64-001"
$TSFile = "$($PSDrivePath)\Control\$($TSID)\ts.xml"

Configuration MDTServer
{
    cMDTBuildTaskSequenceCustomize AddFeatures {
        TSFile      = $TSFile
        Name        = "Install - Microsoft NET Framework 3.5.1"
        GroupName   = "State Restore"
        SubGroup    = "Custom Tasks (Pre-Windows Update)"
        PSDriveName = $PSDriveName
        PSDrivePath = $PSDrivePath
    }
}
