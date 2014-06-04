Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C02C76B7A9
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Jun 2014 13:52:05 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s54DpsR6010326; Wed, 4 Jun 2014 14:51:54 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1Fl2u4g5NAju; Wed,  4 Jun 2014 14:51:53 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s54DplBw010321
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 4 Jun 2014 14:51:49 +0100
Message-ID: <1401889899.12440.153.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Wed, 04 Jun 2014 14:51:39 +0100
In-Reply-To: <CAJ2CSBterj-qqO8PdyqDmFZ_CqocWdF8VZN5fV0=ntyGzR=FYQ@mail.gmail.com>
References: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
	<553c5d33afe658883ceab81d0fe8b0318300dbe7.1401808899.git.alexandru.damian@intel.com>
	<1401813524.12440.112.camel@ted>
	<CAJ2CSBterj-qqO8PdyqDmFZ_CqocWdF8VZN5fV0=ntyGzR=FYQ@mail.gmail.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/9] xmlrpc: client - remove fatal errors
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 04 Jun 2014 13:52:08 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2014-06-04 at 14:20 +0100, Damian, Alexandru wrote:
> Yep, something wrong with it ? 
> 
> 
> The thing is that I'm replacing bb.fatal with bb.warn to get a chance
> for a remote controlling to intercept errors instead of having the
> program shutting down.

But we don't want a print statement for ever idle call?

Cheers,

Richard

> 
> Alex
> 
> 
> On Tue, Jun 3, 2014 at 5:38 PM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>         On Tue, 2014-06-03 at 16:26 +0100, Alex DAMIAN wrote:
>         > From: Alexandru DAMIAN <alexandru.damian@intel.com>
>         >
>         > When we use the XMLRPC client API to connect to a bitbake
>         server,
>         > we want to receive errors from the API instead of having the
>         > API exiting without warning.
>         >
>         > Thus the "bb.fatal" calls have been replaced with "bb.warn"
>         calls,
>         > and we re-raise the original exception for handling by the
>         > original caller.
>         >
>         > The bitbake starting script has been modified to properly
>         test
>         > for failures in calling the client API and handle them.
>         >
>         > Additional error handling added in the client, as to prevent
>         > fatal crashes.
>         >
>         > Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
>         > ---
>         >  bin/bitbake             | 23 +++++++++++++----------
>         >  lib/bb/server/xmlrpc.py | 22 +++++++++++++++-------
>         >  lib/bb/ui/uievent.py    |  3 ++-
>         >  3 files changed, 30 insertions(+), 18 deletions(-)
>         >
>         > diff --git a/bin/bitbake b/bin/bitbake
>         > index fcfe043..ab881c5 100755
>         > --- a/bin/bitbake
>         > +++ b/bin/bitbake
>         > @@ -332,26 +332,29 @@ def main():
>         >          server =
>         servermodule.BitBakeXMLRPCClient(configParams.observe_only)
>         >
>          server.saveConnectionDetails(configParams.remote_server)
>         >
>         > +    def _getServerConnection(server, featureset):
>         > +        try:
>         > +            server_connection =
>         server.establishConnection(featureset)
>         > +        except Exception as e:
>         > +            bb.fatal("Could not connect to server %s: %s" %
>         (configParams.remote_server, str(e)))
>         > +        return server_connection
>         > +
>         >      if not configParams.server_only:
>         >          if configParams.status_only:
>         > -            try:
>         > -                server_connection =
>         server.establishConnection(featureset)
>         > -            except:
>         > -                sys.exit(1)
>         > -            if not server_connection:
>         > -                sys.exit(1)
>         > +            server_connection =
>         _getServerConnection(server, featureset)
>         >              server_connection.terminate()
>         >              sys.exit(0)
>         >
>         >          # Setup a connection to the server (cooker)
>         > -        server_connection =
>         server.establishConnection(featureset)
>         > -        if not server_connection:
>         > +        try:
>         > +            server_connection =
>         server.establishConnection(featureset)
>         > +        except:
>         >              if configParams.kill_server:
>         > -                bb.fatal("Server already killed")
>         > +                bb.fatal("Server already offline")
>         >              configParams.bind = configParams.remote_server
>         >              start_server(servermodule, configParams,
>         configuration, featureset)
>         >              bb.event.ui_queue = []
>         > -            server_connection =
>         server.establishConnection(featureset)
>         > +            server_connection =
>         _getServerConnection(server, featureset)
>         >
>         >          # Restore the environment in case the UI needs it
>         >          for k in cleanedvars:
>         > diff --git a/lib/bb/server/xmlrpc.py
>         b/lib/bb/server/xmlrpc.py
>         > index 6fc5543..6ec3452 100644
>         > --- a/lib/bb/server/xmlrpc.py
>         > +++ b/lib/bb/server/xmlrpc.py
>         > @@ -80,7 +80,7 @@ class BBTransport(xmlrpclib.Transport):
>         >
>         >  def _create_server(host, port, timeout = 60):
>         >      t = BBTransport(timeout)
>         > -    s = xmlrpclib.Server("http://%s:%d/" % (host, port),
>         transport=t, allow_none=True)
>         > +    s = xmlrpclib.ServerProxy("http://%s:%d/" % (host,
>         port), transport=t, allow_none=True)
>         >      return s, t
>         >
>         >  class BitBakeServerCommands():
>         > @@ -253,13 +253,18 @@ class XMLRPCServer(SimpleXMLRPCServer,
>         BaseImplServer):
>         >              socktimeout = self.socket.gettimeout() or
>         nextsleep
>         >              socktimeout = min(socktimeout, nextsleep)
>         >              # Mirror what BaseServer handle_request would
>         do
>         > -            fd_sets = select.select(fds, [], [],
>         socktimeout)
>         > -            if fd_sets[0] and self in fd_sets[0]:
>         > -                self._handle_request_noblock()
>         > +            try:
>         > +                fd_sets = select.select(fds, [], [],
>         socktimeout)
>         > +                if fd_sets[0] and self in fd_sets[0]:
>         > +                    self._handle_request_noblock()
>         > +            except IOError:
>         > +                # we ignore interrupted calls
>         > +                pass
>         >
>         >          # Tell idle functions we're exiting
>         >          for function, data in self._idlefuns.items():
>         >              try:
>         > +                print "Running idle funcs", function, data
>         
>         
>         Did you mean to leave this in?
>         
>         Cheers,
>         
>         Richard
>         
>         >                  retval = function(self, data, True)
>         >              except:
>         >                  pass
>         > @@ -346,7 +351,8 @@ class
>         BitBakeXMLRPCClient(BitBakeBaseServer):
>         >              [host, port] = self.remote.split(":")
>         >              port = int(port)
>         >          except Exception as e:
>         > -            bb.fatal("Failed to read remote definition (%
>         s)" % str(e))
>         > +            bb.warn("Failed to read remote definition (%s)"
>         % str(e))
>         > +            raise e
>         >
>         >          # We need our IP for the server connection. We get
>         the IP
>         >          # by trying to connect with the server
>         > @@ -356,13 +362,15 @@ class
>         BitBakeXMLRPCClient(BitBakeBaseServer):
>         >              ip = s.getsockname()[0]
>         >              s.close()
>         >          except Exception as e:
>         > -            bb.fatal("Could not create socket for %s:%s (%
>         s)" % (host, port, str(e)))
>         > +            bb.warn("Could not create socket for %s:%s (%
>         s)" % (host, port, str(e)))
>         > +            raise e
>         >          try:
>         >              self.serverImpl = XMLRPCProxyServer(host, port)
>         >              self.connection =
>         BitBakeXMLRPCServerConnection(self.serverImpl, (ip, 0),
>         self.observer_only, featureset)
>         >              return self.connection.connect()
>         >          except Exception as e:
>         > -            bb.fatal("Could not connect to server at %s:%s
>         (%s)" % (host, port, str(e)))
>         > +            bb.warn("Could not connect to server at %s:%s
>         (%s)" % (host, port, str(e)))
>         > +            raise e
>         >
>         >      def endSession(self):
>         >          self.connection.removeClient()
>         > diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
>         > index 98658f6..eb760c0 100644
>         > --- a/lib/bb/ui/uievent.py
>         > +++ b/lib/bb/ui/uievent.py
>         > @@ -47,7 +47,8 @@ class BBUIEventQueue:
>         >          self.EventHandle =
>         self.BBServer.registerEventHandler(self.host, self.port)
>         >
>         >          if (self.EventHandle == None):
>         > -            bb.fatal("Could not register UI event handler")
>         > +            bb.warn("Could not register UI event handler %
>         s:%d" % (self.host, self.port))
>         > +            raise Exception("Could not register UI event
>         handler")
>         >
>         >          self.server = server
>         >
>         > --
>         > 1.9.1
>         >
>         
>         
>         
> 
> 
> 
> 
> -- 
> Alex Damian
> Yocto Project
> 
> SSG / OTC 



