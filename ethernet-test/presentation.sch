<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="ALWAYS_HIGH" />
        <signal name="ADC_SAMPLES(7:0)" />
        <signal name="XLXN_9(7:0)" />
        <signal name="XLXN_12(7:0)" />
        <signal name="XLXN_13" />
        <signal name="XLXN_14(7:0)" />
        <signal name="XLXN_16" />
        <signal name="XLXN_17" />
        <signal name="XLXN_18(7:0)" />
        <signal name="XLXN_19(7:0)" />
        <signal name="XLXN_20" />
        <signal name="XLXN_22(7:0)" />
        <signal name="XLXN_23" />
        <port polarity="Input" name="ALWAYS_HIGH" />
        <port polarity="Input" name="ADC_SAMPLES(7:0)" />
        <blockdef name="udp_wrapper">
            <timestamp>2015-5-25T15:15:26</timestamp>
            <rect width="432" x="64" y="-448" height="448" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-320" y2="-320" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-140" height="24" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="560" y1="-416" y2="-416" x1="496" />
            <line x2="560" y1="-352" y2="-352" x1="496" />
            <line x2="560" y1="-288" y2="-288" x1="496" />
            <line x2="560" y1="-224" y2="-224" x1="496" />
            <line x2="560" y1="-160" y2="-160" x1="496" />
            <line x2="560" y1="-96" y2="-96" x1="496" />
            <rect width="64" x="496" y="-44" height="24" />
            <line x2="560" y1="-32" y2="-32" x1="496" />
        </blockdef>
        <blockdef name="ip_wrapper">
            <timestamp>2015-5-25T15:46:50</timestamp>
            <rect width="432" x="64" y="-448" height="448" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-320" y2="-320" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-140" height="24" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="560" y1="-416" y2="-416" x1="496" />
            <line x2="560" y1="-352" y2="-352" x1="496" />
            <line x2="560" y1="-288" y2="-288" x1="496" />
            <line x2="560" y1="-224" y2="-224" x1="496" />
            <line x2="560" y1="-160" y2="-160" x1="496" />
            <line x2="560" y1="-96" y2="-96" x1="496" />
            <rect width="64" x="496" y="-44" height="24" />
            <line x2="560" y1="-32" y2="-32" x1="496" />
        </blockdef>
        <blockdef name="ethernet_wrapper_with_preamble">
            <timestamp>2015-5-25T15:44:50</timestamp>
            <rect width="432" x="64" y="-448" height="448" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-320" y2="-320" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-140" height="24" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="560" y1="-416" y2="-416" x1="496" />
            <line x2="560" y1="-352" y2="-352" x1="496" />
            <line x2="560" y1="-288" y2="-288" x1="496" />
            <line x2="560" y1="-224" y2="-224" x1="496" />
            <line x2="560" y1="-160" y2="-160" x1="496" />
            <line x2="560" y1="-96" y2="-96" x1="496" />
            <rect width="64" x="496" y="-44" height="24" />
            <line x2="560" y1="-32" y2="-32" x1="496" />
        </blockdef>
        <block symbolname="udp_wrapper" name="XLXI_1">
            <blockpin signalname="XLXN_16" name="clk" />
            <blockpin signalname="XLXN_23" name="rst" />
            <blockpin signalname="ALWAYS_HIGH" name="wr_en" />
            <blockpin signalname="ADC_SAMPLES(7:0)" name="data_in(7:0)" />
            <blockpin name="buffer_prog_full_val(10:0)" />
            <blockpin name="busy" />
            <blockpin name="buffer_full" />
            <blockpin name="buffer_empty" />
            <blockpin name="buffer_prog_full" />
            <blockpin signalname="XLXN_17" name="data_valid" />
            <blockpin name="dropped_frame" />
            <blockpin signalname="XLXN_18(7:0)" name="data_out(7:0)" />
        </block>
        <block symbolname="ip_wrapper" name="XLXI_3">
            <blockpin signalname="XLXN_16" name="clk" />
            <blockpin signalname="XLXN_23" name="rst" />
            <blockpin signalname="XLXN_17" name="wr_en" />
            <blockpin signalname="XLXN_18(7:0)" name="data_in(7:0)" />
            <blockpin name="buffer_prog_full_val(10:0)" />
            <blockpin name="busy" />
            <blockpin name="buffer_full" />
            <blockpin name="buffer_empty" />
            <blockpin name="buffer_prog_full" />
            <blockpin signalname="XLXN_20" name="data_valid" />
            <blockpin name="dropped_frame" />
            <blockpin signalname="XLXN_19(7:0)" name="data_out(7:0)" />
        </block>
        <block symbolname="ethernet_wrapper_with_preamble" name="XLXI_4">
            <blockpin signalname="XLXN_16" name="clk" />
            <blockpin signalname="XLXN_23" name="rst" />
            <blockpin signalname="XLXN_20" name="wr_en" />
            <blockpin signalname="XLXN_19(7:0)" name="data_in(7:0)" />
            <blockpin name="buffer_prog_full_val(10:0)" />
            <blockpin name="busy" />
            <blockpin name="buffer_full" />
            <blockpin name="buffer_empty" />
            <blockpin name="buffer_prog_full" />
            <blockpin name="data_valid" />
            <blockpin name="dropped_frame" />
            <blockpin name="data_out(7:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <branch name="ALWAYS_HIGH">
            <wire x2="352" y1="1488" y2="1488" x1="320" />
        </branch>
        <branch name="ADC_SAMPLES(7:0)">
            <wire x2="352" y1="1584" y2="1584" x1="320" />
        </branch>
        <instance x="352" y="1712" name="XLXI_1" orien="R0">
        </instance>
        <iomarker fontsize="28" x="320" y="1584" name="ADC_SAMPLES(7:0)" orien="R180" />
        <iomarker fontsize="28" x="320" y="1488" name="ALWAYS_HIGH" orien="R180" />
        <instance x="1072" y="1712" name="XLXI_3" orien="R0">
        </instance>
        <branch name="XLXN_16">
            <wire x2="288" y1="1184" y2="1296" x1="288" />
            <wire x2="352" y1="1296" y2="1296" x1="288" />
            <wire x2="976" y1="1184" y2="1184" x1="288" />
            <wire x2="976" y1="1184" y2="1296" x1="976" />
            <wire x2="1072" y1="1296" y2="1296" x1="976" />
            <wire x2="1696" y1="1184" y2="1184" x1="976" />
            <wire x2="1696" y1="1184" y2="1296" x1="1696" />
            <wire x2="1872" y1="1296" y2="1296" x1="1696" />
        </branch>
        <branch name="XLXN_17">
            <wire x2="992" y1="1552" y2="1552" x1="912" />
            <wire x2="992" y1="1488" y2="1552" x1="992" />
            <wire x2="1072" y1="1488" y2="1488" x1="992" />
        </branch>
        <branch name="XLXN_18(7:0)">
            <wire x2="992" y1="1680" y2="1680" x1="912" />
            <wire x2="992" y1="1584" y2="1680" x1="992" />
            <wire x2="1072" y1="1584" y2="1584" x1="992" />
        </branch>
        <branch name="XLXN_19(7:0)">
            <wire x2="1760" y1="1680" y2="1680" x1="1632" />
            <wire x2="1872" y1="1584" y2="1584" x1="1760" />
            <wire x2="1760" y1="1584" y2="1680" x1="1760" />
        </branch>
        <instance x="1872" y="1712" name="XLXI_4" orien="R0">
        </instance>
        <branch name="XLXN_20">
            <wire x2="1760" y1="1552" y2="1552" x1="1632" />
            <wire x2="1872" y1="1488" y2="1488" x1="1760" />
            <wire x2="1760" y1="1488" y2="1552" x1="1760" />
        </branch>
        <branch name="XLXN_23">
            <wire x2="240" y1="1088" y2="1392" x1="240" />
            <wire x2="352" y1="1392" y2="1392" x1="240" />
            <wire x2="1040" y1="1088" y2="1088" x1="240" />
            <wire x2="1040" y1="1088" y2="1392" x1="1040" />
            <wire x2="1072" y1="1392" y2="1392" x1="1040" />
            <wire x2="1728" y1="1088" y2="1088" x1="1040" />
            <wire x2="1728" y1="1088" y2="1392" x1="1728" />
            <wire x2="1872" y1="1392" y2="1392" x1="1728" />
        </branch>
    </sheet>
</drawing>