Return-Path: <alexandru.damian@intel.com>
Received: from mail-ob0-f176.google.com (mail-ob0-f176.google.com
	[209.85.214.176])
	by mail.openembedded.org (Postfix) with ESMTP id F2A786FA56
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Jun 2014 14:48:27 +0000 (UTC)
Received: by mail-ob0-f176.google.com with SMTP id wo20so7714421obc.7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Jun 2014 07:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=IJQCXw0+8C2HYEsXUp4CofXqqrC63j09/DajiKWiRds=;
	b=ARqKE1tLp7XmrX034G0hInnnbGLdexryqNVVzolxw3YK+isNZL8W+Ff3DZrSBvDWVE
	TgfH0lz4rlhFyBn/szw4RUJ2uJJE5m7/2OiwT1bThSRFtY0N/okI6w/9Sz+TeyihsGu5
	x5yvf9W4S9PAQ5diK+Mpb+YnRFWxwunUSFV5XDXiCrkegB0rxY/kylpmjSjOLUFgXBSE
	JSK/VU0Z2t0kPRMcHvVoR2cq6T3J27t9C5LdsopyQfR5rF+VckScXJBW6zZkdjPpdGbE
	DB1eb/pRFj1mACcull8/4QfW6xRzpMK2paytXtUpmimp6h2ZQQLQt7iMBf8k/E9qZDMS
	7vXg==
X-Gm-Message-State: ALoCoQnxoloOx1KJYGOKK0M44h0qOejh7IKyJaMMWjS0oBcB2y270t4WNRA2aLSBktgtCDcWwE3n
X-Received: by 10.60.124.108 with SMTP id mh12mr30285986oeb.35.1401893308084; 
	Wed, 04 Jun 2014 07:48:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.11.233 with HTTP; Wed, 4 Jun 2014 07:48:07 -0700 (PDT)
In-Reply-To: <1401893222-23438-1-git-send-email-alexandru.damian@intel.com>
References: <553c5d33afe658883ceab81d0fe8b0318300dbe7.1401808899.git.alexandru.damian@intel.com>
	<1401893222-23438-1-git-send-email-alexandru.damian@intel.com>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Wed, 4 Jun 2014 15:48:07 +0100
Message-ID: <CAJ2CSBtF1vy0fdx=4gt2z0khs9RNCaDYSnse4SJvc1RzZN7+gQ@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: Re: [PATCH 2/9 v2] xmlrpc: client - remove fatal errors
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
X-List-Received-Date: Wed, 04 Jun 2014 14:48:28 -0000
Content-Type: multipart/alternative; boundary=047d7b5d30a4a4494404fb03b8ad

--047d7b5d30a4a4494404fb03b8ad
Content-Type: text/plain; charset=UTF-8

Hello,

I've refactored the patch to take out the print statement that executed on
the last run of the idle functions.

Can you please merge ?

Cheers,
Alex




On Wed, Jun 4, 2014 at 3:47 PM, Alex DAMIAN <alexandru.damian@intel.com>
wrote:

> From: Alexandru DAMIAN <alexandru.damian@intel.com>
>
> When we use the XMLRPC client API to connect to a bitbake server,
> we want to receive errors from the API instead of having the
> API exiting without warning.
>
> Thus the "bb.fatal" calls have been replaced with "bb.warn" calls,
> and we re-raise the original exception for handling by the
> original caller.
>
> The bitbake starting script has been modified to properly test
> for failures in calling the client API and handle them.
>
> Additional error handling added in the client, as to prevent
> fatal crashes.
>
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> ---
>  bin/bitbake             | 23 +++++++++++++----------
>  lib/bb/server/xmlrpc.py | 21 ++++++++++++++-------
>  lib/bb/ui/uievent.py    |  3 ++-
>  3 files changed, 29 insertions(+), 18 deletions(-)
>
> diff --git a/bin/bitbake b/bin/bitbake
> index fcfe043..ab881c5 100755
> --- a/bin/bitbake
> +++ b/bin/bitbake
> @@ -332,26 +332,29 @@ def main():
>          server =
> servermodule.BitBakeXMLRPCClient(configParams.observe_only)
>          server.saveConnectionDetails(configParams.remote_server)
>
> +    def _getServerConnection(server, featureset):
> +        try:
> +            server_connection = server.establishConnection(featureset)
> +        except Exception as e:
> +            bb.fatal("Could not connect to server %s: %s" %
> (configParams.remote_server, str(e)))
> +        return server_connection
> +
>      if not configParams.server_only:
>          if configParams.status_only:
> -            try:
> -                server_connection = server.establishConnection(featureset)
> -            except:
> -                sys.exit(1)
> -            if not server_connection:
> -                sys.exit(1)
> +            server_connection = _getServerConnection(server, featureset)
>              server_connection.terminate()
>              sys.exit(0)
>
>          # Setup a connection to the server (cooker)
> -        server_connection = server.establishConnection(featureset)
> -        if not server_connection:
> +        try:
> +            server_connection = server.establishConnection(featureset)
> +        except:
>              if configParams.kill_server:
> -                bb.fatal("Server already killed")
> +                bb.fatal("Server already offline")
>              configParams.bind = configParams.remote_server
>              start_server(servermodule, configParams, configuration,
> featureset)
>              bb.event.ui_queue = []
> -            server_connection = server.establishConnection(featureset)
> +            server_connection = _getServerConnection(server, featureset)
>
>          # Restore the environment in case the UI needs it
>          for k in cleanedvars:
> diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
> index 6fc5543..d6f4338 100644
> --- a/lib/bb/server/xmlrpc.py
> +++ b/lib/bb/server/xmlrpc.py
> @@ -80,7 +80,7 @@ class BBTransport(xmlrpclib.Transport):
>
>  def _create_server(host, port, timeout = 60):
>      t = BBTransport(timeout)
> -    s = xmlrpclib.Server("http://%s:%d/" % (host, port), transport=t,
> allow_none=True)
> +    s = xmlrpclib.ServerProxy("http://%s:%d/" % (host, port),
> transport=t, allow_none=True)
>      return s, t
>
>  class BitBakeServerCommands():
> @@ -253,9 +253,13 @@ class XMLRPCServer(SimpleXMLRPCServer,
> BaseImplServer):
>              socktimeout = self.socket.gettimeout() or nextsleep
>              socktimeout = min(socktimeout, nextsleep)
>              # Mirror what BaseServer handle_request would do
> -            fd_sets = select.select(fds, [], [], socktimeout)
> -            if fd_sets[0] and self in fd_sets[0]:
> -                self._handle_request_noblock()
> +            try:
> +                fd_sets = select.select(fds, [], [], socktimeout)
> +                if fd_sets[0] and self in fd_sets[0]:
> +                    self._handle_request_noblock()
> +            except IOError:
> +                # we ignore interrupted calls
> +                pass
>
>          # Tell idle functions we're exiting
>          for function, data in self._idlefuns.items():
> @@ -346,7 +350,8 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
>              [host, port] = self.remote.split(":")
>              port = int(port)
>          except Exception as e:
> -            bb.fatal("Failed to read remote definition (%s)" % str(e))
> +            bb.warn("Failed to read remote definition (%s)" % str(e))
> +            raise e
>
>          # We need our IP for the server connection. We get the IP
>          # by trying to connect with the server
> @@ -356,13 +361,15 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
>              ip = s.getsockname()[0]
>              s.close()
>          except Exception as e:
> -            bb.fatal("Could not create socket for %s:%s (%s)" % (host,
> port, str(e)))
> +            bb.warn("Could not create socket for %s:%s (%s)" % (host,
> port, str(e)))
> +            raise e
>          try:
>              self.serverImpl = XMLRPCProxyServer(host, port)
>              self.connection =
> BitBakeXMLRPCServerConnection(self.serverImpl, (ip, 0), self.observer_only,
> featureset)
>              return self.connection.connect()
>          except Exception as e:
> -            bb.fatal("Could not connect to server at %s:%s (%s)" % (host,
> port, str(e)))
> +            bb.warn("Could not connect to server at %s:%s (%s)" % (host,
> port, str(e)))
> +            raise e
>
>      def endSession(self):
>          self.connection.removeClient()
> diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
> index 98658f6..eb760c0 100644
> --- a/lib/bb/ui/uievent.py
> +++ b/lib/bb/ui/uievent.py
> @@ -47,7 +47,8 @@ class BBUIEventQueue:
>          self.EventHandle = self.BBServer.registerEventHandler(self.host,
> self.port)
>
>          if (self.EventHandle == None):
> -            bb.fatal("Could not register UI event handler")
> +            bb.warn("Could not register UI event handler %s:%d" %
> (self.host, self.port))
> +            raise Exception("Could not register UI event handler")
>
>          self.server = server
>
> --
> 1.9.1
>
>


-- 
Alex Damian
Yocto Project
SSG / OTC

--047d7b5d30a4a4494404fb03b8ad
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Hello,</div><div class=3D"gmail_default" style=3D"font-family:ta=
homa,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-famil=
y:tahoma,sans-serif">

I&#39;ve refactored the patch to take out the print statement that executed=
 on the last run of the idle functions.</div><div class=3D"gmail_default" s=
tyle=3D"font-family:tahoma,sans-serif"><br></div><div class=3D"gmail_defaul=
t" style=3D"font-family:tahoma,sans-serif">

Can you please merge ?</div><div class=3D"gmail_default" style=3D"font-fami=
ly:tahoma,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-=
family:tahoma,sans-serif">Cheers,</div><div class=3D"gmail_default" style=
=3D"font-family:tahoma,sans-serif">

Alex</div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-ser=
if"><br></div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans=
-serif"><br></div></div><div class=3D"gmail_extra"><br><br><div class=3D"gm=
ail_quote">

On Wed, Jun 4, 2014 at 3:47 PM, Alex DAMIAN <span dir=3D"ltr">&lt;<a href=
=3D"mailto:alexandru.damian@intel.com" target=3D"_blank">alexandru.damian@i=
ntel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div class=3D"">From: Alexandru DAMIAN &lt;<a href=3D"mailto:alexandru.dami=
an@intel.com">alexandru.damian@intel.com</a>&gt;<br>
<br>
When we use the XMLRPC client API to connect to a bitbake server,<br>
we want to receive errors from the API instead of having the<br>
API exiting without warning.<br>
<br>
Thus the &quot;bb.fatal&quot; calls have been replaced with &quot;bb.warn&q=
uot; calls,<br>
and we re-raise the original exception for handling by the<br>
original caller.<br>
<br>
The bitbake starting script has been modified to properly test<br>
for failures in calling the client API and handle them.<br>
<br>
Additional error handling added in the client, as to prevent<br>
fatal crashes.<br>
<br>
Signed-off-by: Alexandru DAMIAN &lt;<a href=3D"mailto:alexandru.damian@inte=
l.com">alexandru.damian@intel.com</a>&gt;<br>
---<br>
=C2=A0bin/bitbake =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 23 ++++++++++=
+++----------<br>
</div>=C2=A0lib/bb/server/xmlrpc.py | 21 ++++++++++++++-------<br>
=C2=A0lib/bb/ui/uievent.py =C2=A0 =C2=A0| =C2=A03 ++-<br>
=C2=A03 files changed, 29 insertions(+), 18 deletions(-)<br>
<div><div class=3D"h5"><br>
diff --git a/bin/bitbake b/bin/bitbake<br>
index fcfe043..ab881c5 100755<br>
--- a/bin/bitbake<br>
+++ b/bin/bitbake<br>
@@ -332,26 +332,29 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server =3D servermodule.BitBakeXMLRPCClie=
nt(configParams.observe_only)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server.saveConnectionDetails(configParams=
.remote_server)<br>
<br>
+ =C2=A0 =C2=A0def _getServerConnection(server, featureset):<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server_connection =3D server.est=
ablishConnection(featureset)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0except Exception as e:<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fatal(&quot;Could not connect=
 to server %s: %s&quot; % (configParams.remote_server, str(e)))<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return server_connection<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if not configParams.server_only:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if configParams.status_only:<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server_connection =
=3D server.establishConnection(featureset)<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(1)<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not server_connection:<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(1)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server_connection =3D _getServer=
Connection(server, featureset)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server_connection.terminate=
()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(0)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Setup a connection to the server (cooke=
r)<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0server_connection =3D server.establishConnecti=
on(featureset)<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0if not server_connection:<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server_connection =3D server.est=
ablishConnection(featureset)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if configParams.kill_server=
:<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fatal(&quot;Ser=
ver already killed&quot;)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fatal(&quot;Ser=
ver already offline&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0configParams.bind =3D confi=
gParams.remote_server<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0start_server(servermodule, =
configParams, configuration, featureset)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.event.ui_queue =3D []<br=
>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server_connection =3D server.est=
ablishConnection(featureset)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server_connection =3D _getServer=
Connection(server, featureset)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Restore the environment in case the UI =
needs it<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for k in cleanedvars:<br>
diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py<br>
</div></div>index 6fc5543..d6f4338 100644<br>
<div class=3D"">--- a/lib/bb/server/xmlrpc.py<br>
+++ b/lib/bb/server/xmlrpc.py<br>
@@ -80,7 +80,7 @@ class BBTransport(xmlrpclib.Transport):<br>
<br>
=C2=A0def _create_server(host, port, timeout =3D 60):<br>
=C2=A0 =C2=A0 =C2=A0t =3D BBTransport(timeout)<br>
- =C2=A0 =C2=A0s =3D xmlrpclib.Server(&quot;http://%s:%d/&quot; % (host, po=
rt), transport=3Dt, allow_none=3DTrue)<br>
+ =C2=A0 =C2=A0s =3D xmlrpclib.ServerProxy(&quot;http://%s:%d/&quot; % (hos=
t, port), transport=3Dt, allow_none=3DTrue)<br>
=C2=A0 =C2=A0 =C2=A0return s, t<br>
<br>
=C2=A0class BitBakeServerCommands():<br>
</div>@@ -253,9 +253,13 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplS=
erver):<br>
<div class=3D"">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0socktimeout=
 =3D self.socket.gettimeout() or nextsleep<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0socktimeout =3D min(socktim=
eout, nextsleep)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Mirror what BaseServer ha=
ndle_request would do<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd_sets =3D select.select(fds, [=
], [], socktimeout)<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if fd_sets[0] and self in fd_set=
s[0]:<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._handle_reque=
st_noblock()<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd_sets =3D select=
.select(fds, [], [], socktimeout)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if fd_sets[0] and =
self in fd_sets[0]:<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self=
._handle_request_noblock()<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except IOError:<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# we ignore interr=
upted calls<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Tell idle functions we&#39;re exiting<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for function, data in self._idlefuns.item=
s():<br>
</div>@@ -346,7 +350,8 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):<br>
<div class=3D"">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[host, port=
] =3D self.remote.split(&quot;:&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port =3D int(port)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except Exception as e:<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fatal(&quot;Failed to read re=
mote definition (%s)&quot; % str(e))<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.warn(&quot;Failed to read rem=
ote definition (%s)&quot; % str(e))<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise e<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# We need our IP for the server connectio=
n. We get the IP<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# by trying to connect with the server<br=
>
</div>@@ -356,13 +361,15 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):<b=
r>
<div class=3D"HOEnZb"><div class=3D"h5">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ip =3D s.getsockname()[0]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s.close()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except Exception as e:<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fatal(&quot;Could not create =
socket for %s:%s (%s)&quot; % (host, port, str(e)))<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.warn(&quot;Could not create s=
ocket for %s:%s (%s)&quot; % (host, port, str(e)))<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise e<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.serverImpl =3D XMLRPCP=
roxyServer(host, port)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.connection =3D BitBake=
XMLRPCServerConnection(self.serverImpl, (ip, 0), self.observer_only, featur=
eset)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self.connection.conn=
ect()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except Exception as e:<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fatal(&quot;Could not connect=
 to server at %s:%s (%s)&quot; % (host, port, str(e)))<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.warn(&quot;Could not connect =
to server at %s:%s (%s)&quot; % (host, port, str(e)))<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise e<br>
<br>
=C2=A0 =C2=A0 =C2=A0def endSession(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.connection.removeClient()<br>
diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py<br>
index 98658f6..eb760c0 100644<br>
--- a/lib/bb/ui/uievent.py<br>
+++ b/lib/bb/ui/uievent.py<br>
@@ -47,7 +47,8 @@ class BBUIEventQueue:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.EventHandle =3D self.BBServer.regist=
erEventHandler(self.host, self.port)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (self.EventHandle =3D=3D None):<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fatal(&quot;Could not registe=
r UI event handler&quot;)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.warn(&quot;Could not register=
 UI event handler %s:%d&quot; % (self.host, self.port))<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Exception(&quot;Could not =
register UI event handler&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.server =3D server<br>
<br>
--<br>
1.9.1<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div dir=3D"ltr">Alex Damian<div>Yocto Project<br></div><div>SSG / OTC=C2=
=A0</div></div>
</div>

--047d7b5d30a4a4494404fb03b8ad--
