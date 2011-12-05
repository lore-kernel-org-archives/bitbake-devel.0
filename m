Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1RXPJW-0001VG-Cx
	for bitbake-devel@lists.openembedded.org;
	Mon, 05 Dec 2011 04:33:58 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pB53R9Ov003043
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Sun, 4 Dec 2011 19:27:09 -0800 (PST)
Received: from [128.224.162.196] (128.224.162.196) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Sun, 4 Dec 2011 19:27:09 -0800
Message-ID: <4EDC3A0B.4060301@windriver.com>
Date: Mon, 5 Dec 2011 11:27:07 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:8.0) Gecko/20111124 Thunderbird/8.0
MIME-Version: 1.0
To: "Purdie, Richard" <richard.purdie@intel.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.windriver.com id
	pB53R9Ov003043
Cc: bitbake-devel@lists.openembedded.org
Subject: How bitbake works(Draft)
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 05 Dec 2011 03:33:58 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable


Hi Richard,

Here is a doc about how bitbake works, it may help the bitbake
newbie to understand how bitbake works, I'm very glad to add it
to the public bitbake repository as documentation if it is useful.
please feel free to give you comments.


                        How bitbake works

                                      Robert Yang

The document tries to explain a common bitbake build, it is based on
yocto 1.2 and the bitbake version is:

$ bitbake --version
BitBake Build Tool Core version 1.15.0, bitbake version 1.15.0

The entrance of the bitbake is the main() function in bin/bitbake, the
main() function does the following things:

1) Parse command line options
2) Initialize the configuration from the command line options
3) Get the ui and server from the configuration
4) Initialize logger
5) Initialize server
6) Register the idle functions
7) Initialize cooker
8) Parse command line action
9) Add the cooker to the server
10) Start the server and waiting for tasks to run
11) Start the ui
12) The ui runs command on the server

Then the build will start, and stop when the build is done.

1, Parse commandline options


                        -> options (will be used by BBConfiguration)
                       /
                      /
    parser.parse_args (return two values)
                      \
                       \ -> args (will be saved to configuration.pkgs_to_=
build)


    bitbake uses the python moudule optparse to parse the options:

    options, args =3D parser.parse_args(sys.argv)

    For example:

    $bitbake gzip -cpatch

    After the parse, the "options" is a class' instance, and:

    options.cmd =3D "patch"
    There are also many other members in options which would have default
    values.

    and:

    args =3D ['/buildarea/lyang1/poky/bitbake/bin/bitbake', 'gzip']
    The args saves the arguments which has not been matched by the
    option.

2, Initialize the configuration from the commandline options

                BBConfiguration
    options -----------------------> configuration

    configuration =3D BBConfiguration(options)

    BBConfiguration will convert the dictionary of "options" to the
    member of BBConfiguration, and add a member called pkgs_to_build.

    configuration.pkgs_to_build.extend(args[1:])

    Add the arguments to configuration.pkgs_to_build except args[0] (whic=
h
    is the bitbake itself)


3, Get the ui and server from the configuration

                    -> ui_main (will be used by server.launchUI)
                   /
                  /
    configuration
                  \
                   \-> server (will be used to run tasks)

    ui_main =3D get_ui(configuration)

    The get_ui is defined in bin/bitbake, it would use the knotty
    (lib/bb/ui/knotty.py) by default, and use __import__ to import the
    module at runtime. (The "import" can't import the module
    dynamically). The ui_main is the main() function in
    lib/bb/ui/knotty.py

    The similar to the server, the server is lib/bb/server/process.py by
    default.


4) Initialize logger
    * set the log level.

                   ---------> verbose ------->
                  /                           \
                 /                             \
    configuration ------------> debug -------->  bb.msg.init_msgconfig
                 \                             /
                  \                           /
                   --> debug_domains ------->

     bb.msg.init_msgconfig(configuration.verbose, configuration.debug,
                          configuration.debug_domains)


   * set the log handler
     handler =3D bb.event.LogHandler()
     logger.addHandler(handler)

     There are a lot of log handlers, for example: FileHandler,
     SocketHandler, SMTPHandler and so on, but bitbake uses it's own
     handler bb.event.LogHandler to handle the messages. The Loghandler
     is defined in lib/bb/event.py, it re-defines the function emit which
     is used to send the message to the UI(fire(record, None)), and
     redefines the function filter, which is used to filter the messages,
     determine whether to emit the message(all messages would be emitted
     ).

5, Initialize server

    server =3D server.BitBakeServer()
    server.initServer()

    The BitBakeServer() is defined in lib/bb/server/process.py, and the
    server.initServer() will init the server:

            --> ui_channel
           /
    Pipe ()
           \
            --> server_channel ->\                   --> command_channel
                                  \                / --> event_queue
           ----> def waitEvent     -> ProcessServer ----> event
          /                      /                \ ---> _idlefunctions
    ProcessEventQueue --------->/                   ---> keep_running
          \
           ----> def getEvent

    The Pipe () from multiprocessing returns two duplex connection
    objects connected by a pipe here, The ui_channel is used for ui to
    send and receive messages with the server, and the server_channel is
    used for cooker to send and receive messages with the server.

    The ProcessEventQueue is defined in lib/bb/server/process.py: It is
    the subclass of multiprocessing.queues.Queue, the
    multiprocessing.queues.Queue has not defined waitEvent and getEvent
    which are needed by the UI, so define them here.

    The ProcessServer is the real server that we used, it is the
    subclass of Process which is from the multiprocessing:
    * command_channel =3D server_channal

    * event_queue =3D ProcessEventQueue

    * event =3D EventAdapter(event_queue)
      The EventAdapter is used for adapting the API of the queue, the
      bb.event need call a send() method, but our actual queue only has
      put(), so convert the send() to put().

    * The _idlefunctions is used for saving the functions which would be
      run by the server, the register_idle_function will set the value.

    * keep_running =3D Event()
      The Event is from multiprocessing, it will run the
      keep_running.set(), the set() is to set the internal flag to true.
      All processes waiting for it to become true are awakened. Processes
      that call wait() once the flag is true will not block at all.

6, Register the idle functions

    idle =3D server.getServerIdleCB()

    getServerIdleCB --> register_idle_function --> _idlefunctions

    This is used for assigning a value for _idlefunctions in the
    server.

    The function buildFile and buildTargets will use
    server_registration_cb, these are the most important two functions
    for building. And the configuration is one of the most important
    data which saves the configuration data for a build.


7, Initialize cooker

    cooker =3D bb.cooker.BBCooker(configuration, idle, initialenv)

    The BBCooker class is defined in lib/bb/cooker.py, and the
    initialization is:
                                                       +----------------+
                                                       |stateShutdown   |
                                                       |stateStop       |
                                                       |getCmdLineAction|
                          BBCooker      -> cmds_sync ->|getVariable     |
                         /   |    \    /               |setVariable     |
                        /    |     \  /                |resetCooker     |
     server_registration_cb  |    command              +----------------+
     configuration           |        \
     configuration.event_data|         \
                             |          -> cmds_async (see list below)
                             V
                      LoadConfiguration
                     /       |         \
                    /        |          \
     configuration.data      |      configuration.cmd
      (bb.data.init)         |     (BB_DEFAULT_TASK or build)
                             V
                   parseConfigurationFiles
                             |
                             |
                             V
      +---------------------------------------------------+
      |     bb.parse.init_parser --> bb.siggen.init       |
      |     bblayers.conf            (Signature generator)|
      |     BBLAYERS                                      |
      |     BBPATH                                        |
      |     conf/bitbake.conf                             |
      |     base.bblcass                                  |
      |     INHERIT                                       |
      |     register BBHANDLERS                           |
      |     bb.codeparser.parser_cache_init               |
      |     save data to configuration.data               |
      +---------------------------------------------------+

   * loadConfigurationData

     Parse the config file(.conf, base.bbclass, and some .bbclass
     used by the INHERIT), the data will be saved in configuration.data
     (bb.data.init()), we can think it as a dictionary.


  * command
    Bitbake divides the commands into two kinds: cmds_sync and
    cmds_async, cmds_sync has been list in the graph, and cmds_async
    list is:
    buildFile, buildTargets, generateDepTreeEvent, generateDotGraph,
    generateTargetsTree, findConfigFiles, findFilesMatchingInDir,
    findConfigFilePath, showVersions, showEnvironmentTarget,
    showEnvironment, parseFiles, reparseFiles, compareRevisions

    These commands are defined in lib/bb/command.py.

  * The configuration.event_data would be used by the function
    fire().

8, Parse command line action
    cooker.parseCommandLine()

    The parseCommandLine() will save the command line action in the
    dictionary cook.commandlineAction, the default action is
    buildTargets:

    self.commandlineAction['action'] =3D ["buildTargets",=20
self.configuration.pkgs_to_build, self.configuration.cmd]

    The ui will use the server to run "getCmdLineAction", and then
    run buildTargets(self.configuration.pkgs_to_build, self.configuration=
.cmd)
    to build the target. The buildTargets is defined in BBCooker.

9, Add the cooker to the server:

     server.addcooker(cooker)

     server.cooker =3D cooker
     server.server.cooker =3D cooker

     Add the cooker to BitBakeServer and ProcessServer, the first
     "sever" is the "BitBakeServer", and the second server is the
     real server "ProcessServer".

10, Start the server
     server.detach(cooker_logfile)

     This will invoke the detach which is defined in
     lib/bb/server/process.py::BitBakeServer:

     def detach(self, cooker_logfile):
         self.server.start()
         return

     The start() is defined in multiprocessing, which means start the
     process=92 activity.

11, Start the ui

     server_connection =3D server.establishConnection()

     The BitBakeServerConnection will be used to communicate between
     the server and the ui

     server.launchUI(ui_main, server_connection.connection,=20
server_connection.events)

                                      +-----------------+
     launchUI ----> server_main ----> |main in knotty.py|
                                      +-----------------+

     * The default ui is knotty.py

     * The main function in knotty.py is running now.

12, The ui runs command on the server
    * Get the command line action
    * Run the command one the server
    * Waiting for the result from the server and handle them.

     cmdline =3D server.runCommand(["command"])

     If we run "bitbake target", then the flow is:

     +-----------------------------------------------------------+
     |         server.runCommand(["getCmdLineAction"])           |
     | +=3D=3D=3D=3D=3D=3D=3D=3D+              |                         =
        |
     | | The ui |              | return "buildTargets"           |
     | +=3D=3D=3D=3D=3D=3D=3D=3D+              |                         =
        |
     |                         V                                 |
     |         server.runCommand(["buildTargets"])               |
     +-----------------------------------------------------------+
                               |                           ^
                               V                           |
                   command.py::buildTargets                |
                               |                           |
                               V                           | return
     +------------------------------------------------+    |   the
     |             cooker.py::buildTargets            |    |  result
     | +=3D=3D=3D=3D=3D=3D+                |                      |    |
     | |cooker|                V                      |    |
     | +=3D=3D=3D=3D=3D=3D+            updateCache                |    |
     |         (.bb and .bbclass files are parsed)    |    |
     |              taskdata =3D bb.taskdata.TaskData   |    |
     |            rq =3D bb.runqueue.RunQueue           |    |
     |   server_registration_cb(buildTargetsIdle, rq) |    |
     +------------------------------------------------+    |
                               |                           |
                               |                           |
                               V                           |
    +----------------------------------------------------------+
    |   +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+  process.py::run             =
            |
    |   |The server |          |                               |
    |   |is running |          |                               |
    |   +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+          V                   =
            |
    |                  process.py::main                        |
    +----------------------------------------------------------+
                               |     ^
                               |     | return the result
                               V     |
    +----------------------------------------------------------+
    |  +=3D=3D=3D=3D=3D=3D=3D=3D+  cooker.py::buildTargetsIdle           =
      |
    |  | cooker |              |                               |
    |  +=3D=3D=3D=3D=3D=3D=3D=3D+              V                         =
      |
    |                 rq.execute_runqueue                      |
    |             (the tasks are in rq, and begin to run       |
    +----------------------------------------------------------+


// Robert



