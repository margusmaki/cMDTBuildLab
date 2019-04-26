enum Ensure
{
    Absent
    Present
}

[DscResource()]
class cMDTBuildTaskSequenceCondition
{
    # Task Sequence File
    [DscProperty(Key)]
    [string]$TSFile

    # Step name
    [DscProperty(Key)]
    [string]$Name

    # Group for step
    [DscProperty(Mandatory)]
    [string]$GroupName

    # SubGroup for step
    [DscProperty()]
    [string]$SubGroup

    [DscProperty(Mandatory)]
    [string]$PSDriveName

    [DscProperty(Mandatory)]
    [string]$PSDrivePath

    [void] Set()
    {
        $TS = $this.LoadTaskSequence()
    }

    [bool] Test()
    {
        $TS = $this.LoadTaskSequence()
        $present = $false
        $group = $TS.sequence.group | Where-Object {$_.Name -eq $this.GroupName}
        if ($this.Type -eq "Group") {
            $step = $group.group | Where-Object {$_.Name -eq $this.Name}
        }
        else {
            $step = $group.step | Where-Object {$_.Name -eq $this.Name}
        }

        $operator = $step.condition.operator
        if ($operator) {
            $type = $operator.type
        }

        return $present
    }

    [cMDTBuildTaskSequenceCondition] Get()
    {
        return $this
    }

    [xml] LoadTaskSequence()
    {
        $tsPath = $this.TSFile
        $xml = [xml](Get-Content $tsPath)
        return $xml
    }
}
