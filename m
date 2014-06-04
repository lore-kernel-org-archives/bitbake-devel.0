Return-Path: <alexandru.damian@intel.com>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
	[209.85.214.173])
	by mail.openembedded.org (Postfix) with ESMTP id 4BAF06FBC1
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Jun 2014 13:20:35 +0000 (UTC)
Received: by mail-ob0-f173.google.com with SMTP id wm4so7727199obc.32
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Jun 2014 06:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=+EDu9tDmmMzw1GQA5/kzgTPeH298DnAbwQAfoE1p+kw=;
	b=amm/dJyqGnlZrB6vJHXXR5wYCaHrBh4axJFjJpuUtEmUzzOCJpb4/Wr7kw5/xV/F5y
	5iw+9i4833WuWT3NRmuMUsOwSLCJ4xHSRANnLd5CBQU+YzaiL5I8UPcLhXTJVzeLoxVQ
	FwQSUbVivzQEqmlEvjR47G3FEGKgbCo2vtu5oz3XjoxnHIbObZosxN/ne+zBQ1I8Dymu
	ZqhmdAmtnA/QBumo9HupGhuJqcMVkejrTzOcchTIn5UmvZErtNXfglg6P86ZL0UMeq5Y
	212mDUUhrBvmZy73ON4cUaz3I1K4/hLzDwsL2087KXNNK3OHV7r7Z3OmXVivthyH5JgB
	PsjA==
X-Gm-Message-State: ALoCoQnNh1uNV5cxWIoteIr0L34ZOLdXfvWTOqMx1m8xCVPwg5DZFtKkLdOw+tGlbt8kwBhF7PBT
X-Received: by 10.60.124.108 with SMTP id mh12mr29474741oeb.35.1401888036462; 
	Wed, 04 Jun 2014 06:20:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.11.233 with HTTP; Wed, 4 Jun 2014 06:20:16 -0700 (PDT)
In-Reply-To: <1401813524.12440.112.camel@ted>
References: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
	<553c5d33afe658883ceab81d0fe8b0318300dbe7.1401808899.git.alexandru.damian@intel.com>
	<1401813524.12440.112.camel@ted>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Wed, 4 Jun 2014 14:20:16 +0100
Message-ID: <CAJ2CSBterj-qqO8PdyqDmFZ_CqocWdF8VZN5fV0=ntyGzR=FYQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
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
X-List-Received-Date: Wed, 04 Jun 2014 13:20:38 -0000
Content-Type: multipart/alternative; boundary=047d7b5d30a46db70204fb027e1c

--047d7b5d30a46db70204fb027e1c
Content-Type: text/plain; charset=UTF-8

Yep, something wrong with it ?

The thing is that I'm replacing bb.fatal with bb.warn to get a chance for a
remote controlling to intercept errors instead of having the program
shutting down.

Alex


On Tue, Jun 3, 2014 at 5:38 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Tue, 2014-06-03 at 16:26 +0100, Alex DAMIAN wrote:
> > From: Alexandru DAMIAN <alexandru.damian@intel.com>
> >
> > When we use the XMLRPC client API to connect to a bitbake server,
> > we want to receive errors from the API instead of having the
> > API exiting without warning.
> >
> > Thus the "bb.fatal" calls have been replaced with "bb.warn" calls,
> > and we re-raise the original exception for handling by the
> > original caller.
> >
> > The bitbake starting script has been modified to properly test
> > for failures in calling the client API and handle them.
> >
> > Additional error handling added in the client, as to prevent
> > fatal crashes.
> >
> > Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> > ---
> >  bin/bitbake             | 23 +++++++++++++----------
> >  lib/bb/server/xmlrpc.py | 22 +++++++++++++++-------
> >  lib/bb/ui/uievent.py    |  3 ++-
> >  3 files changed, 30 insertions(+), 18 deletions(-)
> >
> > diff --git a/bin/bitbake b/bin/bitbake
> > index fcfe043..ab881c5 100755
> > --- a/bin/bitbake
> > +++ b/bin/bitbake
> > @@ -332,26 +332,29 @@ def main():
> >          server =
> servermodule.BitBakeXMLRPCClient(configParams.observe_only)
> >          server.saveConnectionDetails(configParams.remote_server)
> >
> > +    def _getServerConnection(server, featureset):
> > +        try:
> > +            server_connection = server.establishConnection(featureset)
> > +        except Exception as e:
> > +            bb.fatal("Could not connect to server %s: %s" %
> (configParams.remote_server, str(e)))
> > +        return server_connection
> > +
> >      if not configParams.server_only:
> >          if configParams.status_only:
> > -            try:
> > -                server_connection =
> server.establishConnection(featureset)
> > -            except:
> > -                sys.exit(1)
> > -            if not server_connection:
> > -                sys.exit(1)
> > +            server_connection = _getServerConnection(server, featureset)
> >              server_connection.terminate()
> >              sys.exit(0)
> >
> >          # Setup a connection to the server (cooker)
> > -        server_connection = server.establishConnection(featureset)
> > -        if not server_connection:
> > +        try:
> > +            server_connection = server.establishConnection(featureset)
> > +        except:
> >              if configParams.kill_server:
> > -                bb.fatal("Server already killed")
> > +                bb.fatal("Server already offline")
> >              configParams.bind = configParams.remote_server
> >              start_server(servermodule, configParams, configuration,
> featureset)
> >              bb.event.ui_queue = []
> > -            server_connection = server.establishConnection(featureset)
> > +            server_connection = _getServerConnection(server, featureset)
> >
> >          # Restore the environment in case the UI needs it
> >          for k in cleanedvars:
> > diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
> > index 6fc5543..6ec3452 100644
> > --- a/lib/bb/server/xmlrpc.py
> > +++ b/lib/bb/server/xmlrpc.py
> > @@ -80,7 +80,7 @@ class BBTransport(xmlrpclib.Transport):
> >
> >  def _create_server(host, port, timeout = 60):
> >      t = BBTransport(timeout)
> > -    s = xmlrpclib.Server("http://%s:%d/" % (host, port), transport=t,
> allow_none=True)
> > +    s = xmlrpclib.ServerProxy("http://%s:%d/" % (host, port),
> transport=t, allow_none=True)
> >      return s, t
> >
> >  class BitBakeServerCommands():
> > @@ -253,13 +253,18 @@ class XMLRPCServer(SimpleXMLRPCServer,
> BaseImplServer):
> >              socktimeout = self.socket.gettimeout() or nextsleep
> >              socktimeout = min(socktimeout, nextsleep)
> >              # Mirror what BaseServer handle_request would do
> > -            fd_sets = select.select(fds, [], [], socktimeout)
> > -            if fd_sets[0] and self in fd_sets[0]:
> > -                self._handle_request_noblock()
> > +            try:
> > +                fd_sets = select.select(fds, [], [], socktimeout)
> > +                if fd_sets[0] and self in fd_sets[0]:
> > +                    self._handle_request_noblock()
> > +            except IOError:
> > +                # we ignore interrupted calls
> > +                pass
> >
> >          # Tell idle functions we're exiting
> >          for function, data in self._idlefuns.items():
> >              try:
> > +                print "Running idle funcs", function, data
>
> Did you mean to leave this in?
>
> Cheers,
>
> Richard
>
> >                  retval = function(self, data, True)
> >              except:
> >                  pass
> > @@ -346,7 +351,8 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
> >              [host, port] = self.remote.split(":")
> >              port = int(port)
> >          except Exception as e:
> > -            bb.fatal("Failed to read remote definition (%s)" % str(e))
> > +            bb.warn("Failed to read remote definition (%s)" % str(e))
> > +            raise e
> >
> >          # We need our IP for the server connection. We get the IP
> >          # by trying to connect with the server
> > @@ -356,13 +362,15 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
> >              ip = s.getsockname()[0]
> >              s.close()
> >          except Exception as e:
> > -            bb.fatal("Could not create socket for %s:%s (%s)" % (host,
> port, str(e)))
> > +            bb.warn("Could not create socket for %s:%s (%s)" % (host,
> port, str(e)))
> > +            raise e
> >          try:
> >              self.serverImpl = XMLRPCProxyServer(host, port)
> >              self.connection =
> BitBakeXMLRPCServerConnection(self.serverImpl, (ip, 0), self.observer_only,
> featureset)
> >              return self.connection.connect()
> >          except Exception as e:
> > -            bb.fatal("Could not connect to server at %s:%s (%s)" %
> (host, port, str(e)))
> > +            bb.warn("Could not connect to server at %s:%s (%s)" %
> (host, port, str(e)))
> > +            raise e
> >
> >      def endSession(self):
> >          self.connection.removeClient()
> > diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
> > index 98658f6..eb760c0 100644
> > --- a/lib/bb/ui/uievent.py
> > +++ b/lib/bb/ui/uievent.py
> > @@ -47,7 +47,8 @@ class BBUIEventQueue:
> >          self.EventHandle =
> self.BBServer.registerEventHandler(self.host, self.port)
> >
> >          if (self.EventHandle == None):
> > -            bb.fatal("Could not register UI event handler")
> > +            bb.warn("Could not register UI event handler %s:%d" %
> (self.host, self.port))
> > +            raise Exception("Could not register UI event handler")
> >
> >          self.server = server
> >
> > --
> > 1.9.1
> >
>
>
>


-- 
Alex Damian
Yocto Project
SSG / OTC

--047d7b5d30a46db70204fb027e1c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Yep, something wrong with it ?=C2=A0</div><div class=3D"gmail_de=
fault" style=3D"font-family:tahoma,sans-serif"><br></div><div class=3D"gmai=
l_default" style=3D"font-family:tahoma,sans-serif">

The thing is that I&#39;m replacing bb.fatal with bb.warn to get a chance f=
or a remote controlling to intercept errors instead of having the program s=
hutting down.</div><div class=3D"gmail_default" style=3D"font-family:tahoma=
,sans-serif">

<br></div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-ser=
if">Alex</div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_=
quote">On Tue, Jun 3, 2014 at 5:38 PM, Richard Purdie <span dir=3D"ltr">&lt=
;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">ri=
chard.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
ue, 2014-06-03 at 16:26 +0100, Alex DAMIAN wrote:<br>
&gt; From: Alexandru DAMIAN &lt;<a href=3D"mailto:alexandru.damian@intel.co=
m">alexandru.damian@intel.com</a>&gt;<br>
&gt;<br>
&gt; When we use the XMLRPC client API to connect to a bitbake server,<br>
&gt; we want to receive errors from the API instead of having the<br>
&gt; API exiting without warning.<br>
&gt;<br>
&gt; Thus the &quot;bb.fatal&quot; calls have been replaced with &quot;bb.w=
arn&quot; calls,<br>
&gt; and we re-raise the original exception for handling by the<br>
&gt; original caller.<br>
&gt;<br>
&gt; The bitbake starting script has been modified to properly test<br>
&gt; for failures in calling the client API and handle them.<br>
&gt;<br>
&gt; Additional error handling added in the client, as to prevent<br>
&gt; fatal crashes.<br>
&gt;<br>
&gt; Signed-off-by: Alexandru DAMIAN &lt;<a href=3D"mailto:alexandru.damian=
@intel.com">alexandru.damian@intel.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0bin/bitbake =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 23 +++++=
++++++++----------<br>
&gt; =C2=A0lib/bb/server/xmlrpc.py | 22 +++++++++++++++-------<br>
&gt; =C2=A0lib/bb/ui/uievent.py =C2=A0 =C2=A0| =C2=A03 ++-<br>
&gt; =C2=A03 files changed, 30 insertions(+), 18 deletions(-)<br>
&gt;<br>
&gt; diff --git a/bin/bitbake b/bin/bitbake<br>
&gt; index fcfe043..ab881c5 100755<br>
&gt; --- a/bin/bitbake<br>
&gt; +++ b/bin/bitbake<br>
&gt; @@ -332,26 +332,29 @@ def main():<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server =3D servermodule.BitBakeXMLRP=
CClient(configParams.observe_only)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server.saveConnectionDetails(configP=
arams.remote_server)<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0def _getServerConnection(server, featureset):<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server_connection =3D serve=
r.establishConnection(featureset)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0except Exception as e:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fatal(&quot;Could not co=
nnect to server %s: %s&quot; % (configParams.remote_server, str(e)))<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return server_connection<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0if not configParams.server_only:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if configParams.status_only:<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server_connec=
tion =3D server.establishConnection(featureset)<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(1)<b=
r>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not server_connection:<b=
r>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(1)<b=
r>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server_connection =3D _getS=
erverConnection(server, featureset)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server_connection.term=
inate()<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(0)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Setup a connection to the server (=
cooker)<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0server_connection =3D server.establishCon=
nection(featureset)<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0if not server_connection:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server_connection =3D serve=
r.establishConnection(featureset)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if configParams.kill_s=
erver:<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fatal(&quo=
t;Server already killed&quot;)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fatal(&quo=
t;Server already offline&quot;)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0configParams.bind =3D =
configParams.remote_server<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0start_server(servermod=
ule, configParams, configuration, featureset)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.event.ui_queue =3D =
[]<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server_connection =3D serve=
r.establishConnection(featureset)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server_connection =3D _getS=
erverConnection(server, featureset)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Restore the environment in case th=
e UI needs it<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for k in cleanedvars:<br>
&gt; diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py<br>
&gt; index 6fc5543..6ec3452 100644<br>
&gt; --- a/lib/bb/server/xmlrpc.py<br>
&gt; +++ b/lib/bb/server/xmlrpc.py<br>
&gt; @@ -80,7 +80,7 @@ class BBTransport(xmlrpclib.Transport):<br>
&gt;<br>
&gt; =C2=A0def _create_server(host, port, timeout =3D 60):<br>
&gt; =C2=A0 =C2=A0 =C2=A0t =3D BBTransport(timeout)<br>
&gt; - =C2=A0 =C2=A0s =3D xmlrpclib.Server(&quot;http://%s:%d/&quot; % (hos=
t, port), transport=3Dt, allow_none=3DTrue)<br>
&gt; + =C2=A0 =C2=A0s =3D xmlrpclib.ServerProxy(&quot;http://%s:%d/&quot; %=
 (host, port), transport=3Dt, allow_none=3DTrue)<br>
&gt; =C2=A0 =C2=A0 =C2=A0return s, t<br>
&gt;<br>
&gt; =C2=A0class BitBakeServerCommands():<br>
&gt; @@ -253,13 +253,18 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplS=
erver):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0socktimeout =3D self.s=
ocket.gettimeout() or nextsleep<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0socktimeout =3D min(so=
cktimeout, nextsleep)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Mirror what BaseServ=
er handle_request would do<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd_sets =3D select.select(f=
ds, [], [], socktimeout)<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if fd_sets[0] and self in f=
d_sets[0]:<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._handle_=
request_noblock()<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd_sets =3D s=
elect.select(fds, [], [], socktimeout)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if fd_sets[0]=
 and self in fd_sets[0]:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0self._handle_request_noblock()<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except IOError:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# we ignore i=
nterrupted calls<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Tell idle functions we&#39;re exit=
ing<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for function, data in self._idlefuns=
.items():<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print &quot;R=
unning idle funcs&quot;, function, data<br>
<br>
</div></div>Did you mean to leave this in?<br>
<br>
Cheers,<br>
<br>
Richard<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retval =
=3D function(self, data, True)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
&gt; @@ -346,7 +351,8 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[host, port] =3D self.=
remote.split(&quot;:&quot;)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port =3D int(port)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except Exception as e:<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fatal(&quot;Failed to re=
ad remote definition (%s)&quot; % str(e))<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.warn(&quot;Failed to rea=
d remote definition (%s)&quot; % str(e))<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise e<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# We need our IP for the server conn=
ection. We get the IP<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# by trying to connect with the serv=
er<br>
&gt; @@ -356,13 +362,15 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ip =3D s.getsockname()=
[0]<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s.close()<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except Exception as e:<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fatal(&quot;Could not cr=
eate socket for %s:%s (%s)&quot; % (host, port, str(e)))<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.warn(&quot;Could not cre=
ate socket for %s:%s (%s)&quot; % (host, port, str(e)))<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise e<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.serverImpl =3D XM=
LRPCProxyServer(host, port)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.connection =3D Bi=
tBakeXMLRPCServerConnection(self.serverImpl, (ip, 0), self.observer_only, f=
eatureset)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self.connection=
.connect()<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except Exception as e:<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fatal(&quot;Could not co=
nnect to server at %s:%s (%s)&quot; % (host, port, str(e)))<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.warn(&quot;Could not con=
nect to server at %s:%s (%s)&quot; % (host, port, str(e)))<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise e<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0def endSession(self):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.connection.removeClient()<br>
&gt; diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py<br>
&gt; index 98658f6..eb760c0 100644<br>
&gt; --- a/lib/bb/ui/uievent.py<br>
&gt; +++ b/lib/bb/ui/uievent.py<br>
&gt; @@ -47,7 +47,8 @@ class BBUIEventQueue:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.EventHandle =3D self.BBServer.r=
egisterEventHandler(self.host, self.port)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (self.EventHandle =3D=3D None):<b=
r>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fatal(&quot;Could not re=
gister UI event handler&quot;)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.warn(&quot;Could not reg=
ister UI event handler %s:%d&quot; % (self.host, self.port))<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Exception(&quot;Could=
 not register UI event handler&quot;)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.server =3D server<br>
&gt;<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div dir=3D"ltr">Alex Damian<div>Yocto Project<br></div><div>SSG / OTC=C2=
=A0</div></div>
</div>

--047d7b5d30a46db70204fb027e1c--
