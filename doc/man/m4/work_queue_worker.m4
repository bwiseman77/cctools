include(manual.h)dnl
HEADER(work_queue_worker)

SECTION(NAME)
BOLD(work_queue_worker) - worker process for executing tasks
dispatched through Work Queue

SECTION(SYNOPSIS)
CODE(work_queue_worker [options] PARAM(managerhost) PARAM(port))

CODE(work_queue_worker [options] PARAM(managerhost:port]))

CODE(work_queue_worker [options] "PARAM(managerhost:port;[managerhost:port;managerhost:port;...])))

CODE(work_queue_worker [options] -M PARAM(projectname))

SECTION(DESCRIPTION)

BOLD(work_queue_worker) is the worker process for executing tasks dispatched
from a manager application built using the BOLD(Work Queue) API. BOLD(work_queue_worker)
connects to the manager application, accepts, runs, and returns tasks dispatched to it.

PARA

The BOLD(managerhost) and BOLD(port) arguments specify the hostname and port
number of the manager application for work_queue_worker to connect. Several
managerhosts and ports may be specified, separated with a semicolon (;), with the
worker connecting to any of the managers specified (When specifying multiple
managers, remember to escape the ; from shell interpretation, for example, using
quotes.)

Alternatevely, the manager may be specified by name, using the BOLD(-M) option.

PARA

BOLD(work_queue_worker) can be run locally or deployed remotely on any of the
grid or cloud computing environments such as SGE, PBS, SLURM, and HTCondor using
MANPAGE(sge_submit_workers,1), MANPAGE(pbs_submit_workers,1), MANPAGE(slurm_submit_workers), and MANPAGE(condor_submit_workers,1) respectively.

SECTION(OPTIONS)
OPTIONS_BEGIN
OPTION_FLAG(v, version)Show version string.
OPTION_FLAG(h, help)Show this help message.
OPTION_ARG(M, manager-name, name)Set the name of the project this worker should work for.  A worker can have multiple projects.
OPTION_ARG(C, catalog, catalog)Set catalog server to PARAM(catalog). Format: HOSTNAME:PORT
OPTION_ARG(d, debug, flag)Enable debugging for the given subsystem. Try -d all as a start.
OPTION_ARG(o,debug-file,file)Write debugging output to this file. By default, debugging is sent to stderr (":stderr"). You may specify logs to be sent to stdout (":stdout") instead.
OPTION_ARG_LONG(debug-max-rotate, bytes)Set the maximum file size of the debug log.  If the log exceeds this size, it is renamed to "filename.old" and a new logfile is opened.  (default=10M. 0 disables)
OPTION_FLAG_LONG(debug-release-reset)Debug file will be closed, renamed, and a new one opened after being released from a manager.
OPTION_FLAG_LONG(foreman)Enable foreman mode.
OPTION_ARG(f, foreman-name, name)Set the project name of this foreman to PARAM(project). Implies --foreman.
OPTION_ARG_LONG(foreman-port, port[:highport]) Set the port for the foreman to listen on.  If PARAM(highport) is specified the port is chosen from between PARAM(port) and PARAM(highport). Implies --foreman.
OPTION_ARG(Z, foreman-port-file, file)Select port to listen to at random and write to this file.  Implies --foreman.
OPTION_ARG(F, fast-abort, mult)Set the fast abort multiplier for foreman (default=disabled).
OPTION_ARG_LONG(specify-log, logfile)Send statistics about foreman to this file.
OPTION_ARG(P, password, pwfile)Password file for authenticating to the manager.
OPTION_ARG(t, timeout, time)Abort after this amount of idle time. (default=900s)
OPTION_FLAG_LONG(parent-death)Exit if parent process dies.
OPTION_ARG(w, tcp-window-size, size)Set TCP window size.
OPTION_ARG(i, min-backoff, time)Set initial value for backoff interval when worker fails to connect to a manager. (default=1s)
OPTION_ARG(b, max-backoff, time)Set maxmimum value for backoff interval when worker fails to connect to a manager. (default=60s)
OPTION_ARG(A, arch, arch)Set the architecture string the worker reports to its supervisor. (default=the value reported by uname)
OPTION_ARG(O, os, os)Set the operating system string the worker reports to its supervisor. (default=the value reported by uname)
OPTION_ARG(s, workdir, path)Set the location where the worker should create its working directory. (default=/tmp)
OPTION_ARG_LONG(bandwidth, mbps)Set the maximum bandwidth the foreman will consume in Mbps. (default=unlimited)
OPTION_ARG_LONG(cores, n)Set the number of cores this worker should use.  Set it to 0 to have the worker use all of the available resources. (default=1)
OPTION_ARG_LONG(gpus, n)Set the number of GPUs this worker should use. If less than 0 or not given, try to detect gpus available.
OPTION_ARG_LONG(memory, mb)Manually set the amount of memory (in MB) reported by this worker.
OPTION_ARG_LONG(disk, mb)Manually set the amount of disk space (in MB) reported by this worker.
OPTION_ARG_LONG(wall-time, s)Set the maximum number of seconds the worker may be active.
OPTION_ARG_LONG(feature, feature)Specifies a user-defined feature the worker provides (option can be repeated).
OPTION_ARG_LONG(volatility, chance)Set the percent chance per minute that the worker will shut down (simulates worker failures, for testing only).
OPTION_ARG_LONG(connection-mode, mode)When using -M, override manager preference to resolve its address. One of by_ip, by_hostname, or by_apparent_ip. Default is set by manager.
OPTIONS_END

SECTION(FOREMAN MODE)

BOLD(work_queue_worker) can also be run in BOLD(foreman) mode, in which it connects to a
manager as a worker while acting as a manager itself.  Any tasks the foreman receives from
its manager are sent to its subordinate worker processes.

PARA

BOLD(Foreman) mode is enabled by either specifying a port to listen on using the BOLD(--foreman --foreman-port PARAM(port)) option or by
setting the mode directly with the BOLD(--foreman --foreman-name PARAM(foreman_name))
option.  The foreman works for the manager specified with the with the BOLD(-M PARAM(project name)) flag.

SECTION(EXIT STATUS)
On success, returns zero.  On failure, returns non-zero.

SECTION(EXAMPLES)

To run BOLD(work_queue_worker) to join a specific manager process running on host CODE(manager.somewhere.edu) port 9123:
LONGCODE_BEGIN
% work_queue_worker manager.somewhere.edu 9123
LONGCODE_END

To run BOLD(work_queue_worker) in auto mode with debugging turned on for all subsystems and
to accept tasks only from a manager application with project name set to project_A:
LONGCODE_BEGIN
% work_queue_worker -a -d all -M project_A
LONGCODE_END

To run BOLD(work_queue_worker) as a foreman working for project_A and advertising itself as foreman_A1:
LONGCODE_BEGIN
% work_queue_worker --foreman -M project_A -f foreman_A1
LONGCODE_END

SECTION(COPYRIGHT)

COPYRIGHT_BOILERPLATE

SECTION(SEE ALSO)

SEE_ALSO_WORK_QUEUE

FOOTER
