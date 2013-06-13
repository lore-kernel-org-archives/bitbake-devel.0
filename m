Return-Path: <alex.r.damian@gmail.com>
Received: from mail-ea0-f196.google.com (mail-ea0-f196.google.com
	[209.85.215.196])
	by mail.openembedded.org (Postfix) with ESMTP id B65E362195
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Jun 2013 15:23:15 +0000 (UTC)
Received: by mail-ea0-f196.google.com with SMTP id q10so2685430eaj.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Jun 2013 08:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding;
	bh=toQVvzj7WEx8KDonvZykybvUENCE/ny4rxhk2awPwtw=;
	b=yoWKfAPpXIi6YSpe0qgA7D5eUuhgFbM8gx/RG6qFpOo2DEjFJJotY7vdMwc8oFYA3l
	OFPjzs8fXnOt7uQaaP4FC2UzPFeFo2+KfhQtl0I7yKw9Dnrlnu82ueoucbrhtPDFmIPK
	9DGQWqBJMyZrV2z1QUs4ZU/ihchIXfFsa1NDrHG/f0acas/5QJ6fmsJve/Yi7+osGcwp
	LtQKiMGJBMOXaPUqv7pSaKwbnFLRnL6HQrnkeaIvINglnSkHZYS1qoQKVqsAqdhiN7hg
	t7QzqrbGvo87wd7BATaVgzDC35wYC5cxkTenlsGZ5AEPUDtK788bZFLBg3O3htNMTfY1
	C0gw==
X-Received: by 10.15.33.132 with SMTP id c4mr1440763eev.12.1371136996110;
	Thu, 13 Jun 2013 08:23:16 -0700 (PDT)
Received: from [192.198.151.44] ([192.198.151.44])
	by mx.google.com with ESMTPSA id 3sm44447536een.7.2013.06.13.08.23.14
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 13 Jun 2013 08:23:15 -0700 (PDT)
Message-ID: <51B9E3E1.8020905@gmail.com>
Date: Thu, 13 Jun 2013 16:23:13 +0100
From: Alex Damian <alex.r.damian@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <1370619726-22780-1-git-send-email-alexandru.damian@intel.com>
	<1371042680.20823.24.camel@ted>
In-Reply-To: <1371042680.20823.24.camel@ted>
Subject: Re: [PATCH] knotty, xmlrpc: add observer-only mode
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 13 Jun 2013 15:23:16 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 06/12/2013 02:11 PM, Richard Purdie wrote:
> On Fri, 2013-06-07 at 16:42 +0100, Alex DAMIAN wrote:
>> From: Alexandru DAMIAN <alexandru.damian@intel.com>
>>
>> I add an observer only mode for the knotty UI and
>> the XMLRPC server that will allow the UI to register
>> a callback with a server in order to receive events.
>>
>> The observer-UI will not send any commands to the
>> server apart from registering as an event handler.
>>
>> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
>> ---
>>   bin/bitbake             |  8 +++++++-
>>   lib/bb/server/xmlrpc.py | 18 ++++++++++++------
>>   lib/bb/ui/knotty.py     | 29 +++++++++++++++++------------
>>   lib/bb/ui/uievent.py    |  1 +
>>   4 files changed, 37 insertions(+), 19 deletions(-)
>>
>> diff --git a/bin/bitbake b/bin/bitbake
>> index d263cbd..ef0c5d8 100755
>> --- a/bin/bitbake
>> +++ b/bin/bitbake
>> @@ -197,6 +197,9 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
>>           parser.add_option("", "--remote-server", help = "Connect to the specified server",
>>                      action = "store", dest = "remote_server", default = False)
>>   
>> +        parser.add_option("", "--observe-only", help = "Connect to a server as an observing-only client",
>> +                   action = "store_true", dest = "observe_only", default = False)
>> +
>>           options, targets = parser.parse_args(sys.argv)
>>           return options, targets[1:]
>>   
>> @@ -269,6 +272,9 @@ def main():
>>       if configParams.remote_server and configParams.servertype != "xmlrpc":
>>           sys.exit("FATAL: If '--remote-server' is defined, we must set the servertype as 'xmlrpc'.\n")
>>   
>> +    if configParams.observe_only and (not configParams.remote_server or configParams.bind):
>> +        sys.exit("FATAL: '--observe-only' can only be used by UI clients connecting to a server.\n")
>> +
>>       if "BBDEBUG" in os.environ:
>>           level = int(os.environ["BBDEBUG"])
>>           if level > configuration.debug:
>> @@ -295,7 +301,7 @@ def main():
>>           server = start_server(servermodule, configParams, configuration)
>>       else:
>>           # we start a stub server that is actually a XMLRPClient to
>> -        server = servermodule.BitBakeXMLRPCClient()
>> +        server = servermodule.BitBakeXMLRPCClient(configParams.observe_only)
>>           server.saveConnectionDetails(configParams.remote_server)
>>   
>>       logger.removeHandler(handler)
>> diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
>> index 0b51ebd..1b3502e 100644
>> --- a/lib/bb/server/xmlrpc.py
>> +++ b/lib/bb/server/xmlrpc.py
>> @@ -214,7 +214,7 @@ class BitBakeXMLRPCRequestHandler(SimpleXMLRPCRequestHandler):
>>               remote_token = self.headers["Bitbake-token"]
>>           except:
>>               remote_token = None
>> -        if remote_token != self.connection_token:
>> +        if remote_token != self.connection_token and remote_token != "observer":
>>               self.report_503()
>>           else:
>>               SimpleXMLRPCRequestHandler.do_POST(self)
>> @@ -424,13 +424,17 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
>>           self.connection_token = token
>>   
>>   class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
>> -    def __init__(self, serverImpl, clientinfo=("localhost", 0)):
>> +    def __init__(self, serverImpl, clientinfo=("localhost", 0), observer_only = False):
>>           self.connection, self.transport = _create_server(serverImpl.host, serverImpl.port)
>>           self.clientinfo = clientinfo
>>           self.serverImpl = serverImpl
>> +        self.observer_only = observer_only
>>   
>>       def connect(self):
>> -        token = self.connection.addClient()
>> +        if not self.observer_only:
>> +            token = self.connection.addClient()
>> +        else:
>> +            token = "observer"
>>           if token is None:
>>               return None
>>           self.transport.set_connection_token(token)
>> @@ -440,7 +444,8 @@ class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
>>           return self
>>   
>>       def removeClient(self):
>> -        self.connection.removeClient()
>> +        if not self.observer_only:
>> +            self.connection.removeClient()
>>   
>>       def terminate(self):
>>           # Don't wait for server indefinitely
>> @@ -472,7 +477,8 @@ class BitBakeServer(BitBakeBaseServer):
>>   
>>   class BitBakeXMLRPCClient(BitBakeBaseServer):
>>   
>> -    def __init__(self):
>> +    def __init__(self, observer_only = False):
>> +        self.observer_only = observer_only
>>           pass
>>   
>>       def saveConnectionDetails(self, remote):
>> @@ -495,7 +501,7 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
>>           except:
>>               return None
>>           self.serverImpl = XMLRPCProxyServer(host, port)
>> -        self.connection = BitBakeXMLRPCServerConnection(self.serverImpl, (ip, 0))
>> +        self.connection = BitBakeXMLRPCServerConnection(self.serverImpl, (ip, 0), self.observer_only)
>>           return self.connection.connect()
>>   
>>       def endSession(self):
>> diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
>> index 389c3cc..465203f 100644
>> --- a/lib/bb/ui/knotty.py
>> +++ b/lib/bb/ui/knotty.py
>> @@ -216,21 +216,28 @@ class TerminalFilter(object):
>>               fd = sys.stdin.fileno()
>>               self.termios.tcsetattr(fd, self.termios.TCSADRAIN, self.stdinbackup)
>>   
>> -def main(server, eventHandler, params, tf = TerminalFilter):
>> -
>> +def _log_settings_from_server(server):
>>       # Get values of variables which control our output
>>       includelogs, error = server.runCommand(["getVariable", "BBINCLUDELOGS"])
>>       if error:
>>           logger.error("Unable to get the value of BBINCLUDELOGS variable: %s" % error)
>> -        return 1
>> +        raise error
>>       loglines, error = server.runCommand(["getVariable", "BBINCLUDELOGS_LINES"])
>>       if error:
>>           logger.error("Unable to get the value of BBINCLUDELOGS_LINES variable: %s" % error)
>> -        return 1
>> +        raise error
>>       consolelogfile, error = server.runCommand(["getVariable", "BB_CONSOLELOG"])
>>       if error:
>>           logger.error("Unable to get the value of BB_CONSOLELOG variable: %s" % error)
>> -        return 1
>> +        raise error
>> +    return includelogs, loglines, consolelogfile
>> +
>> +def main(server, eventHandler, params, tf = TerminalFilter):
>> +
>> +    if params.observe_only:
>> +        includelogs, loglines, consolelogfile = None, None, None
>> +    else:
>> +        includelogs, loglines, consolelogfile = _log_settings_from_server(server)
> This doesn't look right. Even in observe mode, I'd expect to see the
> same console output.
>
> This raises the question, even in observe only mode, can't we run sync
> commands, just not async commands or write commands?
>
>>       if sys.stdin.isatty() and sys.stdout.isatty():
>>           log_exec_tty = True
>> @@ -254,7 +261,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
>>           consolelog.setFormatter(conlogformat)
>>           logger.addHandler(consolelog)
>>   
>> -    try:
>> +    if not params.observe_only:
>>           params.updateFromServer(server)
>>           cmdline = params.parseActions()
>>           if not cmdline:
>> @@ -271,9 +278,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
>>           elif ret != True:
>>               logger.error("Command '%s' failed: returned %s" % (cmdline, ret))
>>               return 1
>> -    except xmlrpclib.Fault as x:
>> -        logger.error("XMLRPC Fault getting commandline:\n %s" % x)
>> -        return 1
>> +
>>   
>>       parseprogress = None
>>       cacheprogress = None
>> @@ -320,7 +325,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
>>                   elif event.levelno == format.WARNING:
>>                       warnings = warnings + 1
>>                   # For "normal" logging conditions, don't show note logs from tasks
>> -                # but do show them if the user has changed the default log level to
>> +                # but do show them if the user has changed the default log level to
>>                   # include verbose/debug messages
>>                   if event.taskpid != 0 and event.levelno <= format.NOTE:
>>                       continue
>> @@ -469,12 +474,12 @@ def main(server, eventHandler, params, tf = TerminalFilter):
>>                   pass
>>           except KeyboardInterrupt:
>>               termfilter.clearFooter()
>> -            if main.shutdown == 1:
>> +            if not params.observe_only and main.shutdown == 1:
>>                   print("\nSecond Keyboard Interrupt, stopping...\n")
>>                   _, error = server.runCommand(["stateStop"])
>>                   if error:
>>                       logger.error("Unable to cleanly stop: %s" % error)
>> -            if main.shutdown == 0:
>> +            if not params.observe_only and main.shutdown == 0:
>>                   print("\nKeyboard Interrupt, closing down...\n")
>>                   interrupted = True
>>                   _, error = server.runCommand(["stateShutdown"])
>> diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
>> index 0b9a836..038029f 100644
>> --- a/lib/bb/ui/uievent.py
>> +++ b/lib/bb/ui/uievent.py
>> @@ -84,6 +84,7 @@ class BBUIEventQueue:
>>   
>>       def startCallbackHandler(self):
>>   
>> +        self.server.timeout = 1
>>           while not self.server.quit:
>>               self.server.handle_request()
>>           self.server.server_close()
> Why? The commit message doesn't mention timeouts.
It's an implementation detail. If not there, than the server will hang 
indefinitely waiting for a command, and not ever processing the 
self.server.quit variable in the while.

>
> Cheers,
>
> Richard
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel


