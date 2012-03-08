Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1S5Yix-000585-NP
	for bitbake-devel@lists.openembedded.org;
	Thu, 08 Mar 2012 09:29:24 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q288Kg8j014132
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 8 Mar 2012 00:20:42 -0800 (PST)
Received: from [128.224.162.196] (128.224.162.196) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Thu, 8 Mar 2012 00:20:41 -0800
Message-ID: <4F586BD7.2040206@windriver.com>
Date: Thu, 8 Mar 2012 16:20:39 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:9.0) Gecko/20111229 Thunderbird/9.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <4EDC3A0B.4060301@windriver.com> <1323262909.30601.13.camel@ted>
In-Reply-To: <1323262909.30601.13.camel@ted>
X-MIME-Autoconverted: from 8bit to quoted-printable by mail1.windriver.com id
	q288Kg8j014132
Cc: bitbake-devel@lists.openembedded.org, "Rifenbark,
	Scott M" <scott.m.rifenbark@intel.com>
Subject: Re: How bitbake works(Draft)
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
X-List-Received-Date: Thu, 08 Mar 2012 08:29:24 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable


Hi Richard,

Here is an updated one.

Changes:

1) Remove the function's arguments as many as possible, try
    to make it easy to maintain.

2) Change the name from "How bitbake works" to
    "A Brief introduction to bitbake internal"

3) Try to explain rather than put the code there.

4) Some other trivial fix

Please see the document at the end of the email.

// Robert

On 12/07/2011 09:01 PM, Richard Purdie wrote:
> Hi Robert,
>
> On Mon, 2011-12-05 at 11:27 +0800, Robert Yang wrote:
>> Here is a doc about how bitbake works, it may help the bitbake
>> newbie to understand how bitbake works, I'm very glad to add it
>> to the public bitbake repository as documentation if it is useful.
>> please feel free to give you comments.
>
> I like this and I do think we need to improve the bitbake documentation.
> We do need to ensure there is some consistent style and format for the
> documents though so anything going into the repository really needs to
> be added to the existing manual.
>
> I'm also a little concerned that in its current form (listing arguments
> to functions), this documentation would be high maintenance. If we coul=
d
> separate it from the code implementation details a little bit, I think
> it would make it less likely to bitrot quite as quickly.
>
> Cheers,
>
> Richard
>
>



	A Brief introduction to bitbake internal


The document tries to explain how a common bitbake build runs, it is
based on the yocto project.

The entrance of the bitbake is the main() function in bin/bitbake, the
main() function does the following things:

1, Parse command line options
    * options are something like -b, -f, -c and so on.

2, Initialize the configuration
    * The configuration saves the options data here, and will save more
      later, the metadata(.conf, .inc, .bbclass and so on) will be saved
      in configuration.data.

3, Get the ui and server from the configuration
    * The ui is the user interface, you can specify which interface you
      prefer.
    * The server is used for running the tasks.

4, Initialize the logger
    * The logger is used for logging the messages.

5, Initialize server
    * Prepare the server for running

6, Register the idle functions
    * Register the functions to the server, and the server will invoke
      the function when it is idle.

7, Initialize cooker
    * The cooker manages one bitbake build run, and it will save the
      metadata to configuration.data here.

8, Parse command line action
    * The actions are: fetch, unpack, patch and so on, the default is
      build.

9, Add the cooker to the server
    * Let the server can use the data in the cooker

10, Start the server and waiting for tasks to come to run

11, Start the ui

12, The ui submits commands to the server
     * Then the build will start, and stop when it is done.

Let's see them one by one:

1, Parse command line options
    * parser.parse_args
      It returns two values: options and args, the options will be used
      by the BBConfiguration

      options, args =3D parser.parse_args

      For example:

      $bitbake gzip -cpatch

      After the parse:

      options.cmd =3D "patch"
      The args saves the arguments which has not been matched by the
      option:
      args =3D ['/buildarea/lyang1/poky/bitbake/bin/bitbake', 'gzip']

2, Initialize the configuration from the commandline options

                BBConfiguration
    options -----------------------> configuration

    configuration =3D BBConfiguration

    BBConfiguration converts the dictionary of the "options" to the
    member of BBConfiguration, and add a member called pkgs_to_build,
    which will be used for saving the build pkg:

    configuration.pkgs_to_build.extend

    The configuration and configuration.data are the most important data
    during a build, they save everything of the build.

3, Get the ui and server from the configuration

    There are several UI and server in yocto, the default UI and server
    are knotty(lib/bb/ui/knotty.py) and (lib/bb/server/process.py), you
    can specify another ui by "bitbake -u <ui>", and "bitbake -t <server>=
"
    for server.

    The ui will be started by the server: server.launchUI.
    The server will be used for running the tasks.

4, Initialize the logger
    * set the log level.
      bb.msg.init_msgconfig

    * set the log handler
      handler =3D bb.event.LogHandler()
      logger.addHandler

      There are lots of log handlers, for example: FileHandler,
      SocketHandler, SMTPHandler and so on, but bitbake uses it's own
      handler bb.event.LogHandler to handle the messages. This Loghandler
      is defined in lib/bb/event.py, it re-defines the function emit
      which is used to send the message to the UI, and redefines the
      function filter which is used for determining whether to emit
      the message(all messages would be emitted).

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
      To receive the command to run.

    * event_queue =3D ProcessEventQueue
      Supply the API waitEvent and getEvent, so that the ui can use the
      same API for different servers.

    * event =3D EventAdapter
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
    for building.

7, Initialize cooker

    cooker =3D bb.cooker.BBCooker

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
      |     save metadata to configuration.data           |
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
    run buildTargets to build the target. The buildTargets is defined
    in BBCooker.

9, Add the cooker to the server:

     server.cooker =3D cooker

     Add the cooker to BitBakeServer, so the server can use the data in
     the cooker

10, Start the server and waiting for tasks to come to run
     server.detach

     This will invoke the function server.start() which is in
     lib/bb/server/process.py::BitBakeServer:

     The server.start() is defined in multiprocessing, which means start
     the process=E2=80=99 activity.

11, Start the ui

     server_connection =3D server.establishConnection()

     The BitBakeServerConnection will be used to communicate between
     the server and the ui

     server.launchUI

     * The main() function in knotty.py is running now.

12, The ui submits commands to the server
    * Get the command line action
    * Run the command one the server
    * Waiting for the result from the server and handle them.

     cmdline =3D server.runCommand

     If we run "bitbake target", then the flow is:

     +-----------------------------------------------------------+
     |                 server.runCommand                         |
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
     |              server_registration_cb            |    |
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
    |             (the tasks are in rq, and begin to run)      |
    +----------------------------------------------------------+


    The build will stop when the tasks in the runqueue has been done.





