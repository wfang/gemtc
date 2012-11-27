
# generated by stc
# date: 2012/11/19 16:34:34

package require turbine 0.0.6
namespace import turbine::*


proc swift:constants {  } {
    turbine::c::log "function:swift:constants"
    global c:f_0.0
    turbine::allocate c:f_0.0 float
    turbine::store_float ${c:f_0.0} 0.0
    global c:i_1
    turbine::allocate c:i_1 integer
    turbine::store_integer ${c:i_1} 1
    global c:i_2500
    turbine::allocate c:i_2500 integer
    turbine::store_integer ${c:i_2500} 2500
}

package require sleep1 0.0.1


proc swift:main {  } {
    turbine::c::log "enter function: main"
    set stack 0
    turbine::allocate_container t:0 integer
    global c:i_1
    global c:i_2500
    # Swift l.9: assigning expression to bound
    turbine::rangestep ${stack} [ list ${t:0} ] [ list ${c:i_1} ${c:i_2500} ${c:i_1} ]
    turbine::c::rule main-foreach_arr_wait0 [ list ${t:0} ] ${turbine::LOCAL} [ list main-foreach_arr_wait0 ${stack} ${t:0} ]
}


proc main-foreach_arr_wait0 { stack t:0 } {
    set tcltmp:contents [ adlb::enumerate ${t:0} members all 0 ]
    foreach u:i ${tcltmp:contents} {
        turbine::allocate t:3 float
        global c:f_0.0
        # Swift l.16: assigning expression to A[_]
        sleep1::c_sleep ${stack} [ list ${t:3} ] [ list ${c:f_0.0} ]
    }
}

turbine::defaults
turbine::init $engines $servers
turbine::start swift:main swift:constants
turbine::finalize

