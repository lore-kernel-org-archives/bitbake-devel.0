Return-Path: <alexandru.damian@intel.com>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
	[209.85.214.169])
	by mail.openembedded.org (Postfix) with ESMTP id D072460030
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Jun 2014 14:39:09 +0000 (UTC)
Received: by mail-ob0-f169.google.com with SMTP id vb8so7845816obc.28
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Jun 2014 07:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=u6Dk1bGJ1WUGEg1cQl5MEyUlCTHTteQaT2ym29GC3OI=;
	b=Gz98SCxm6eMMTZwcdzTO8cEf+l+LWaFGj9QmFpkxjttyZumHbxg3JiSQqm+HgVWHUA
	D+fpvQxuTsPsu4qZhzmFYILFCaBJ+uMBJtBbEe9njFRR2wIU9x8K49WvGDBKa5cdiXJb
	oFUJDZ8fkTLUkZhG80hB4Q0b3jsyhxW5zhe0w3IhVgruKecBZ+clOpYCwbrODYVLlJon
	6Z19uqvmnctZDq95fSAjzZAzn1x+aLb3Z6aJ8wAzBQAYUzhntNW4N1jafpSQy76wj2bY
	WEb5Q8NXb6gwbJ36IlQCulLyYVgzVFqtZJeZzGyLjjIxC30hkncc5+089NeV2T3dO+CE
	heyA==
X-Gm-Message-State: ALoCoQmqHCIBtRifZZPaBu0E84jD0nFsmtbmq6wwnXHZnMKtKzbu/SfzC2U+EtM56EKEsu8vQUdz
X-Received: by 10.60.70.200 with SMTP id o8mr57371351oeu.55.1401892750556;
	Wed, 04 Jun 2014 07:39:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.11.233 with HTTP; Wed, 4 Jun 2014 07:38:49 -0700 (PDT)
In-Reply-To: <1401889899.12440.153.camel@ted>
References: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
	<553c5d33afe658883ceab81d0fe8b0318300dbe7.1401808899.git.alexandru.damian@intel.com>
	<1401813524.12440.112.camel@ted>
	<CAJ2CSBterj-qqO8PdyqDmFZ_CqocWdF8VZN5fV0=ntyGzR=FYQ@mail.gmail.com>
	<1401889899.12440.153.camel@ted>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Wed, 4 Jun 2014 15:38:49 +0100
Message-ID: <CAJ2CSBu2xWMF3GjiY+rBEP_D4BZDmkhdjDZHHFypt+mHGV44GA@mail.gmail.com>
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
X-List-Received-Date: Wed, 04 Jun 2014 14:39:13 -0000
Content-Type: multipart/alternative; boundary=001a113344606953d404fb039713

--001a113344606953d404fb039713
Content-Type: text/plain; charset=UTF-8

Oh, now I get it - my email client didn't highlight that you replied to a
specific line -

this is mostly for debugging purposes, to be able to manually monitor the
bitbake running by
> tail -f bitbake-cookerdaemon.log file

Proabably should be in a different patch, though - let me redo this patch.

Thanks,

Alex


On Wed, Jun 4, 2014 at 2:51 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2014-06-04 at 14:20 +0100, Damian, Alexandru wrote:
> > Yep, something wrong with it ?
> >
> >
> > The thing is that I'm replacing bb.fatal with bb.warn to get a chance
> > for a remote controlling to intercept errors instead of having the
> > program shutting down.
>
> But we don't want a print statement for ever idle call?
>
> Cheers,
>
> Richard
>
> >
> > Alex
> >
> >
> > On Tue, Jun 3, 2014 at 5:38 PM, Richard Purdie
> > <richard.purdie@linuxfoundation.org> wrote:
> >         On Tue, 2014-06-03 at 16:26 +0100, Alex DAMIAN wrote:
> >         > From: Alexandru DAMIAN <alexandru.damian@intel.com>
> >         >
> >         > When we use the XMLRPC client API to connect to a bitbake
> >         server,
> >         > we want to receive errors from the API instead of having the
> >         > API exiting without warning.
> >         >
> >         > Thus the "bb.fatal" calls have been replaced with "bb.warn"
> >         calls,
> >         > and we re-raise the original exception for handling by the
> >         > original caller.
> >         >
> >         > The bitbake starting script has been modified to properly
> >         test
> >         > for failures in calling the client API and handle them.
> >         >
> >         > Additional error handling added in the client, as to prevent
> >         > fatal crashes.
> >         >
> >         > Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> >         > ---
> >         >  bin/bitbake             | 23 +++++++++++++----------
> >         >  lib/bb/server/xmlrpc.py | 22 +++++++++++++++-------
> >         >  lib/bb/ui/uievent.py    |  3 ++-
> >         >  3 files changed, 30 insertions(+), 18 deletions(-)
> >         >
> >         > diff --git a/bin/bitbake b/bin/bitbake
> >         > index fcfe043..ab881c5 100755
> >         > --- a/bin/bitbake
> >         > +++ b/bin/bitbake
> >         > @@ -332,26 +332,29 @@ def main():
> >         >          server =
> >         servermodule.BitBakeXMLRPCClient(configParams.observe_only)
> >         >
> >          server.saveConnectionDetails(configParams.remote_server)
> >         >
> >         > +    def _getServerConnection(server, featureset):
> >         > +        try:
> >         > +            server_connection =
> >         server.establishConnection(featureset)
> >         > +        except Exception as e:
> >         > +            bb.fatal("Could not connect to server %s: %s" %
> >         (configParams.remote_server, str(e)))
> >         > +        return server_connection
> >         > +
> >         >      if not configParams.server_only:
> >         >          if configParams.status_only:
> >         > -            try:
> >         > -                server_connection =
> >         server.establishConnection(featureset)
> >         > -            except:
> >         > -                sys.exit(1)
> >         > -            if not server_connection:
> >         > -                sys.exit(1)
> >         > +            server_connection =
> >         _getServerConnection(server, featureset)
> >         >              server_connection.terminate()
> >         >              sys.exit(0)
> >         >
> >         >          # Setup a connection to the server (cooker)
> >         > -        server_connection =
> >         server.establishConnection(featureset)
> >         > -        if not server_connection:
> >         > +        try:
> >         > +            server_connection =
> >         server.establishConnection(featureset)
> >         > +        except:
> >         >              if configParams.kill_server:
> >         > -                bb.fatal("Server already killed")
> >         > +                bb.fatal("Server already offline")
> >         >              configParams.bind = configParams.remote_server
> >         >              start_server(servermodule, configParams,
> >         configuration, featureset)
> >         >              bb.event.ui_queue = []
> >         > -            server_connection =
> >         server.establishConnection(featureset)
> >         > +            server_connection =
> >         _getServerConnection(server, featureset)
> >         >
> >         >          # Restore the environment in case the UI needs it
> >         >          for k in cleanedvars:
> >         > diff --git a/lib/bb/server/xmlrpc.py
> >         b/lib/bb/server/xmlrpc.py
> >         > index 6fc5543..6ec3452 100644
> >         > --- a/lib/bb/server/xmlrpc.py
> >         > +++ b/lib/bb/server/xmlrpc.py
> >         > @@ -80,7 +80,7 @@ class BBTransport(xmlrpclib.Transport):
> >         >
> >         >  def _create_server(host, port, timeout = 60):
> >         >      t = BBTransport(timeout)
> >         > -    s = xmlrpclib.Server("http://%s:%d/" % (host, port),
> >         transport=t, allow_none=True)
> >         > +    s = xmlrpclib.ServerProxy("http://%s:%d/" % (host,
> >         port), transport=t, allow_none=True)
> >         >      return s, t
> >         >
> >         >  class BitBakeServerCommands():
> >         > @@ -253,13 +253,18 @@ class XMLRPCServer(SimpleXMLRPCServer,
> >         BaseImplServer):
> >         >              socktimeout = self.socket.gettimeout() or
> >         nextsleep
> >         >              socktimeout = min(socktimeout, nextsleep)
> >         >              # Mirror what BaseServer handle_request would
> >         do
> >         > -            fd_sets = select.select(fds, [], [],
> >         socktimeout)
> >         > -            if fd_sets[0] and self in fd_sets[0]:
> >         > -                self._handle_request_noblock()
> >         > +            try:
> >         > +                fd_sets = select.select(fds, [], [],
> >         socktimeout)
> >         > +                if fd_sets[0] and self in fd_sets[0]:
> >         > +                    self._handle_request_noblock()
> >         > +            except IOError:
> >         > +                # we ignore interrupted calls
> >         > +                pass
> >         >
> >         >          # Tell idle functions we're exiting
> >         >          for function, data in self._idlefuns.items():
> >         >              try:
> >         > +                print "Running idle funcs", function, data
> >
> >
> >         Did you mean to leave this in?
> >
> >         Cheers,
> >
> >         Richard
> >
> >         >                  retval = function(self, data, True)
> >         >              except:
> >         >                  pass
> >         > @@ -346,7 +351,8 @@ class
> >         BitBakeXMLRPCClient(BitBakeBaseServer):
> >         >              [host, port] = self.remote.split(":")
> >         >              port = int(port)
> >         >          except Exception as e:
> >         > -            bb.fatal("Failed to read remote definition (%
> >         s)" % str(e))
> >         > +            bb.warn("Failed to read remote definition (%s)"
> >         % str(e))
> >         > +            raise e
> >         >
> >         >          # We need our IP for the server connection. We get
> >         the IP
> >         >          # by trying to connect with the server
> >         > @@ -356,13 +362,15 @@ class
> >         BitBakeXMLRPCClient(BitBakeBaseServer):
> >         >              ip = s.getsockname()[0]
> >         >              s.close()
> >         >          except Exception as e:
> >         > -            bb.fatal("Could not create socket for %s:%s (%
> >         s)" % (host, port, str(e)))
> >         > +            bb.warn("Could not create socket for %s:%s (%
> >         s)" % (host, port, str(e)))
> >         > +            raise e
> >         >          try:
> >         >              self.serverImpl = XMLRPCProxyServer(host, port)
> >         >              self.connection =
> >         BitBakeXMLRPCServerConnection(self.serverImpl, (ip, 0),
> >         self.observer_only, featureset)
> >         >              return self.connection.connect()
> >         >          except Exception as e:
> >         > -            bb.fatal("Could not connect to server at %s:%s
> >         (%s)" % (host, port, str(e)))
> >         > +            bb.warn("Could not connect to server at %s:%s
> >         (%s)" % (host, port, str(e)))
> >         > +            raise e
> >         >
> >         >      def endSession(self):
> >         >          self.connection.removeClient()
> >         > diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
> >         > index 98658f6..eb760c0 100644
> >         > --- a/lib/bb/ui/uievent.py
> >         > +++ b/lib/bb/ui/uievent.py
> >         > @@ -47,7 +47,8 @@ class BBUIEventQueue:
> >         >          self.EventHandle =
> >         self.BBServer.registerEventHandler(self.host, self.port)
> >         >
> >         >          if (self.EventHandle == None):
> >         > -            bb.fatal("Could not register UI event handler")
> >         > +            bb.warn("Could not register UI event handler %
> >         s:%d" % (self.host, self.port))
> >         > +            raise Exception("Could not register UI event
> >         handler")
> >         >
> >         >          self.server = server
> >         >
> >         > --
> >         > 1.9.1
> >         >
> >
> >
> >
> >
> >
> >
> >
> > --
> > Alex Damian
> > Yocto Project
> >
> > SSG / OTC
>
>
>


-- 
Alex Damian
Yocto Project
SSG / OTC

--001a113344606953d404fb039713
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OnRhaG9tYSxzYW5zLXNlcmlmIj5PaCwgbm93IEkgZ2V0IGl0IC0gbXkgZW1haWwgY2xpZW50
IGRpZG4mIzM5O3QgaGlnaGxpZ2h0IHRoYXQgeW91IHJlcGxpZWQgdG8gYSBzcGVjaWZpYyBsaW5l
IC08L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dGFo
b21hLHNhbnMtc2VyaWYiPg0KDQo8YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIg
c3R5bGU9ImZvbnQtZmFtaWx5OnRhaG9tYSxzYW5zLXNlcmlmIj50aGlzIGlzIG1vc3RseSBmb3Ig
ZGVidWdnaW5nIHB1cnBvc2VzLCB0byBiZSBhYmxlIHRvIG1hbnVhbGx5IG1vbml0b3IgdGhlIGJp
dGJha2UgcnVubmluZyBiecKgPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9
ImZvbnQtZmFtaWx5OnRhaG9tYSxzYW5zLXNlcmlmIj4NCg0KJmd0OyB0YWlsIC1mIGJpdGJha2Ut
Y29va2VyZGFlbW9uLmxvZyBmaWxlwqA8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBz
dHlsZT0iZm9udC1mYW1pbHk6dGFob21hLHNhbnMtc2VyaWYiPjxicj48L2Rpdj48ZGl2IGNsYXNz
PSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dGFob21hLHNhbnMtc2VyaWYiPlBy
b2FiYWJseSBzaG91bGQgYmUgaW4gYSBkaWZmZXJlbnQgcGF0Y2gsIHRob3VnaCAtIGxldCBtZSBy
ZWRvIHRoaXMgcGF0Y2guPC9kaXY+DQoNCjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxl
PSJmb250LWZhbWlseTp0YWhvbWEsc2Fucy1zZXJpZiI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9Imdt
YWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp0YWhvbWEsc2Fucy1zZXJpZiI+VGhhbmtz
LDwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp0YWhv
bWEsc2Fucy1zZXJpZiI+PGJyPg0KDQo8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBz
dHlsZT0iZm9udC1mYW1pbHk6dGFob21hLHNhbnMtc2VyaWYiPkFsZXg8L2Rpdj48L2Rpdj48ZGl2
IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24g
V2VkLCBKdW4gNCwgMjAxNCBhdCAyOjUxIFBNLCBSaWNoYXJkIFB1cmRpZSA8c3BhbiBkaXI9Imx0
ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpyaWNoYXJkLnB1cmRpZUBsaW51eGZvdW5kYXRpb24ub3Jn
IiB0YXJnZXQ9Il9ibGFuayI+cmljaGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZzwvYT4m
Z3Q7PC9zcGFuPiB3cm90ZTo8YnI+DQoNCjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIg
c3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRp
bmctbGVmdDoxZXgiPjxkaXYgY2xhc3M9IiI+T24gV2VkLCAyMDE0LTA2LTA0IGF0IDE0OjIwICsw
MTAwLCBEYW1pYW4sIEFsZXhhbmRydSB3cm90ZTo8YnI+DQomZ3Q7IFllcCwgc29tZXRoaW5nIHdy
b25nIHdpdGggaXQgPzxicj4NCiZndDs8YnI+DQomZ3Q7PGJyPg0KJmd0OyBUaGUgdGhpbmcgaXMg
dGhhdCBJJiMzOTttIHJlcGxhY2luZyBiYi5mYXRhbCB3aXRoIGJiLndhcm4gdG8gZ2V0IGEgY2hh
bmNlPGJyPg0KJmd0OyBmb3IgYSByZW1vdGUgY29udHJvbGxpbmcgdG8gaW50ZXJjZXB0IGVycm9y
cyBpbnN0ZWFkIG9mIGhhdmluZyB0aGU8YnI+DQomZ3Q7IHByb2dyYW0gc2h1dHRpbmcgZG93bi48
YnI+DQo8YnI+DQo8L2Rpdj5CdXQgd2UgZG9uJiMzOTt0IHdhbnQgYSBwcmludCBzdGF0ZW1lbnQg
Zm9yIGV2ZXIgaWRsZSBjYWxsPzxicj4NCjxicj4NCkNoZWVycyw8YnI+DQo8YnI+DQpSaWNoYXJk
PGJyPg0KPGRpdiBjbGFzcz0iSE9FblpiIj48ZGl2IGNsYXNzPSJoNSI+PGJyPg0KJmd0Ozxicj4N
CiZndDsgQWxleDxicj4NCiZndDs8YnI+DQomZ3Q7PGJyPg0KJmd0OyBPbiBUdWUsIEp1biAzLCAy
MDE0IGF0IDU6MzggUE0sIFJpY2hhcmQgUHVyZGllPGJyPg0KJmd0OyAmbHQ7PGEgaHJlZj0ibWFp
bHRvOnJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5vcmciPnJpY2hhcmQucHVyZGllQGxp
bnV4Zm91bmRhdGlvbi5vcmc8L2E+Jmd0OyB3cm90ZTo8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgIE9u
IFR1ZSwgMjAxNC0wNi0wMyBhdCAxNjoyNiArMDEwMCwgQWxleCBEQU1JQU4gd3JvdGU6PGJyPg0K
Jmd0OyDCoCDCoCDCoCDCoCAmZ3Q7IEZyb206IEFsZXhhbmRydSBEQU1JQU4gJmx0OzxhIGhyZWY9
Im1haWx0bzphbGV4YW5kcnUuZGFtaWFuQGludGVsLmNvbSI+YWxleGFuZHJ1LmRhbWlhbkBpbnRl
bC5jb208L2E+Jmd0Ozxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0Ozxicj4NCiZndDsgwqAgwqAg
wqAgwqAgJmd0OyBXaGVuIHdlIHVzZSB0aGUgWE1MUlBDIGNsaWVudCBBUEkgdG8gY29ubmVjdCB0
byBhIGJpdGJha2U8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgIHNlcnZlciw8YnI+DQomZ3Q7IMKgIMKg
IMKgIMKgICZndDsgd2Ugd2FudCB0byByZWNlaXZlIGVycm9ycyBmcm9tIHRoZSBBUEkgaW5zdGVh
ZCBvZiBoYXZpbmcgdGhlPGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7IEFQSSBleGl0aW5nIHdp
dGhvdXQgd2FybmluZy48YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDs8YnI+DQomZ3Q7IMKgIMKg
IMKgIMKgICZndDsgVGh1cyB0aGUgJnF1b3Q7YmIuZmF0YWwmcXVvdDsgY2FsbHMgaGF2ZSBiZWVu
IHJlcGxhY2VkIHdpdGggJnF1b3Q7YmIud2FybiZxdW90Ozxicj4NCiZndDsgwqAgwqAgwqAgwqAg
Y2FsbHMsPGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7IGFuZCB3ZSByZS1yYWlzZSB0aGUgb3Jp
Z2luYWwgZXhjZXB0aW9uIGZvciBoYW5kbGluZyBieSB0aGU8YnI+DQomZ3Q7IMKgIMKgIMKgIMKg
ICZndDsgb3JpZ2luYWwgY2FsbGVyLjxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0Ozxicj4NCiZn
dDsgwqAgwqAgwqAgwqAgJmd0OyBUaGUgYml0YmFrZSBzdGFydGluZyBzY3JpcHQgaGFzIGJlZW4g
bW9kaWZpZWQgdG8gcHJvcGVybHk8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgIHRlc3Q8YnI+DQomZ3Q7
IMKgIMKgIMKgIMKgICZndDsgZm9yIGZhaWx1cmVzIGluIGNhbGxpbmcgdGhlIGNsaWVudCBBUEkg
YW5kIGhhbmRsZSB0aGVtLjxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0Ozxicj4NCiZndDsgwqAg
wqAgwqAgwqAgJmd0OyBBZGRpdGlvbmFsIGVycm9yIGhhbmRsaW5nIGFkZGVkIGluIHRoZSBjbGll
bnQsIGFzIHRvIHByZXZlbnQ8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsgZmF0YWwgY3Jhc2hl
cy48YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDs8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsg
U2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IERBTUlBTiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFsZXhh
bmRydS5kYW1pYW5AaW50ZWwuY29tIj5hbGV4YW5kcnUuZGFtaWFuQGludGVsLmNvbTwvYT4mZ3Q7
PGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7IC0tLTxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0
OyDCoGJpbi9iaXRiYWtlIMKgIMKgIMKgIMKgIMKgIMKgIHwgMjMgKysrKysrKysrKysrKy0tLS0t
LS0tLS08YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsgwqBsaWIvYmIvc2VydmVyL3htbHJwYy5w
eSB8IDIyICsrKysrKysrKysrKysrKy0tLS0tLS08YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsg
wqBsaWIvYmIvdWkvdWlldmVudC5weSDCoCDCoHwgwqAzICsrLTxicj4NCiZndDsgwqAgwqAgwqAg
wqAgJmd0OyDCoDMgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25z
KC0pPGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7PGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7
IGRpZmYgLS1naXQgYS9iaW4vYml0YmFrZSBiL2Jpbi9iaXRiYWtlPGJyPg0KJmd0OyDCoCDCoCDC
oCDCoCAmZ3Q7IGluZGV4IGZjZmUwNDMuLmFiODgxYzUgMTAwNzU1PGJyPg0KJmd0OyDCoCDCoCDC
oCDCoCAmZ3Q7IC0tLSBhL2Jpbi9iaXRiYWtlPGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7ICsr
KyBiL2Jpbi9iaXRiYWtlPGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7IEBAIC0zMzIsMjYgKzMz
MiwyOSBAQCBkZWYgbWFpbigpOjxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyDCoCDCoCDCoCDC
oCDCoHNlcnZlciA9PGJyPg0KJmd0OyDCoCDCoCDCoCDCoCBzZXJ2ZXJtb2R1bGUuQml0QmFrZVhN
TFJQQ0NsaWVudChjb25maWdQYXJhbXMub2JzZXJ2ZV9vbmx5KTxicj4NCiZndDsgwqAgwqAgwqAg
wqAgJmd0Ozxicj4NCiZndDsgwqAgwqAgwqAgwqAgwqBzZXJ2ZXIuc2F2ZUNvbm5lY3Rpb25EZXRh
aWxzKGNvbmZpZ1BhcmFtcy5yZW1vdGVfc2VydmVyKTxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0
Ozxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyArIMKgIMKgZGVmIF9nZXRTZXJ2ZXJDb25uZWN0
aW9uKHNlcnZlciwgZmVhdHVyZXNldCk6PGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7ICsgwqAg
wqAgwqAgwqB0cnk6PGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7ICsgwqAgwqAgwqAgwqAgwqAg
wqBzZXJ2ZXJfY29ubmVjdGlvbiA9PGJyPg0KJmd0OyDCoCDCoCDCoCDCoCBzZXJ2ZXIuZXN0YWJs
aXNoQ29ubmVjdGlvbihmZWF0dXJlc2V0KTxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyArIMKg
IMKgIMKgIMKgZXhjZXB0IEV4Y2VwdGlvbiBhcyBlOjxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0
OyArIMKgIMKgIMKgIMKgIMKgIMKgYmIuZmF0YWwoJnF1b3Q7Q291bGQgbm90IGNvbm5lY3QgdG8g
c2VydmVyICVzOiAlcyZxdW90OyAlPGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAoY29uZmlnUGFyYW1z
LnJlbW90ZV9zZXJ2ZXIsIHN0cihlKSkpPGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7ICsgwqAg
wqAgwqAgwqByZXR1cm4gc2VydmVyX2Nvbm5lY3Rpb248YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZn
dDsgKzxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyDCoCDCoCDCoGlmIG5vdCBjb25maWdQYXJh
bXMuc2VydmVyX29ubHk6PGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7IMKgIMKgIMKgIMKgIMKg
aWYgY29uZmlnUGFyYW1zLnN0YXR1c19vbmx5Ojxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyAt
IMKgIMKgIMKgIMKgIMKgIMKgdHJ5Ojxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyAtIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgc2VydmVyX2Nvbm5lY3Rpb24gPTxicj4NCiZndDsgwqAgwqAgwqAg
wqAgc2VydmVyLmVzdGFibGlzaENvbm5lY3Rpb24oZmVhdHVyZXNldCk8YnI+DQomZ3Q7IMKgIMKg
IMKgIMKgICZndDsgLSDCoCDCoCDCoCDCoCDCoCDCoGV4Y2VwdDo8YnI+DQomZ3Q7IMKgIMKgIMKg
IMKgICZndDsgLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5cy5leGl0KDEpPGJyPg0KJmd0OyDC
oCDCoCDCoCDCoCAmZ3Q7IC0gwqAgwqAgwqAgwqAgwqAgwqBpZiBub3Qgc2VydmVyX2Nvbm5lY3Rp
b246PGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBz
eXMuZXhpdCgxKTxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyArIMKgIMKgIMKgIMKgIMKgIMKg
c2VydmVyX2Nvbm5lY3Rpb24gPTxicj4NCiZndDsgwqAgwqAgwqAgwqAgX2dldFNlcnZlckNvbm5l
Y3Rpb24oc2VydmVyLCBmZWF0dXJlc2V0KTxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyDCoCDC
oCDCoCDCoCDCoCDCoCDCoHNlcnZlcl9jb25uZWN0aW9uLnRlcm1pbmF0ZSgpPGJyPg0KJmd0OyDC
oCDCoCDCoCDCoCAmZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzLmV4aXQoMCk8YnI+DQomZ3Q7
IMKgIMKgIMKgIMKgICZndDs8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsgwqAgwqAgwqAgwqAg
wqAjIFNldHVwIGEgY29ubmVjdGlvbiB0byB0aGUgc2VydmVyIChjb29rZXIpPGJyPg0KJmd0OyDC
oCDCoCDCoCDCoCAmZ3Q7IC0gwqAgwqAgwqAgwqBzZXJ2ZXJfY29ubmVjdGlvbiA9PGJyPg0KJmd0
OyDCoCDCoCDCoCDCoCBzZXJ2ZXIuZXN0YWJsaXNoQ29ubmVjdGlvbihmZWF0dXJlc2V0KTxicj4N
CiZndDsgwqAgwqAgwqAgwqAgJmd0OyAtIMKgIMKgIMKgIMKgaWYgbm90IHNlcnZlcl9jb25uZWN0
aW9uOjxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyArIMKgIMKgIMKgIMKgdHJ5Ojxicj4NCiZn
dDsgwqAgwqAgwqAgwqAgJmd0OyArIMKgIMKgIMKgIMKgIMKgIMKgc2VydmVyX2Nvbm5lY3Rpb24g
PTxicj4NCiZndDsgwqAgwqAgwqAgwqAgc2VydmVyLmVzdGFibGlzaENvbm5lY3Rpb24oZmVhdHVy
ZXNldCk8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsgKyDCoCDCoCDCoCDCoGV4Y2VwdDo8YnI+
DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBjb25maWdQYXJh
bXMua2lsbF9zZXJ2ZXI6PGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7IC0gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBiYi5mYXRhbCgmcXVvdDtTZXJ2ZXIgYWxyZWFkeSBraWxsZWQmcXVvdDspPGJy
Pg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBiYi5mYXRh
bCgmcXVvdDtTZXJ2ZXIgYWxyZWFkeSBvZmZsaW5lJnF1b3Q7KTxicj4NCiZndDsgwqAgwqAgwqAg
wqAgJmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbmZpZ1BhcmFtcy5iaW5kID0gY29uZmlnUGFy
YW1zLnJlbW90ZV9zZXJ2ZXI8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsgwqAgwqAgwqAgwqAg
wqAgwqAgwqBzdGFydF9zZXJ2ZXIoc2VydmVybW9kdWxlLCBjb25maWdQYXJhbXMsPGJyPg0KJmd0
OyDCoCDCoCDCoCDCoCBjb25maWd1cmF0aW9uLCBmZWF0dXJlc2V0KTxicj4NCiZndDsgwqAgwqAg
wqAgwqAgJmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoGJiLmV2ZW50LnVpX3F1ZXVlID0gW108YnI+
DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsgLSDCoCDCoCDCoCDCoCDCoCDCoHNlcnZlcl9jb25uZWN0
aW9uID08YnI+DQomZ3Q7IMKgIMKgIMKgIMKgIHNlcnZlci5lc3RhYmxpc2hDb25uZWN0aW9uKGZl
YXR1cmVzZXQpPGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7ICsgwqAgwqAgwqAgwqAgwqAgwqBz
ZXJ2ZXJfY29ubmVjdGlvbiA9PGJyPg0KJmd0OyDCoCDCoCDCoCDCoCBfZ2V0U2VydmVyQ29ubmVj
dGlvbihzZXJ2ZXIsIGZlYXR1cmVzZXQpPGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7PGJyPg0K
Jmd0OyDCoCDCoCDCoCDCoCAmZ3Q7IMKgIMKgIMKgIMKgIMKgIyBSZXN0b3JlIHRoZSBlbnZpcm9u
bWVudCBpbiBjYXNlIHRoZSBVSSBuZWVkcyBpdDxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyDC
oCDCoCDCoCDCoCDCoGZvciBrIGluIGNsZWFuZWR2YXJzOjxicj4NCiZndDsgwqAgwqAgwqAgwqAg
Jmd0OyBkaWZmIC0tZ2l0IGEvbGliL2JiL3NlcnZlci94bWxycGMucHk8YnI+DQomZ3Q7IMKgIMKg
IMKgIMKgIGIvbGliL2JiL3NlcnZlci94bWxycGMucHk8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZn
dDsgaW5kZXggNmZjNTU0My4uNmVjMzQ1MiAxMDA2NDQ8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZn
dDsgLS0tIGEvbGliL2JiL3NlcnZlci94bWxycGMucHk8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZn
dDsgKysrIGIvbGliL2JiL3NlcnZlci94bWxycGMucHk8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZn
dDsgQEAgLTgwLDcgKzgwLDcgQEAgY2xhc3MgQkJUcmFuc3BvcnQoeG1scnBjbGliLlRyYW5zcG9y
dCk6PGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7PGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7
IMKgZGVmIF9jcmVhdGVfc2VydmVyKGhvc3QsIHBvcnQsIHRpbWVvdXQgPSA2MCk6PGJyPg0KJmd0
OyDCoCDCoCDCoCDCoCAmZ3Q7IMKgIMKgIMKgdCA9IEJCVHJhbnNwb3J0KHRpbWVvdXQpPGJyPg0K
Jmd0OyDCoCDCoCDCoCDCoCAmZ3Q7IC0gwqAgwqBzID0geG1scnBjbGliLlNlcnZlcigmcXVvdDto
dHRwOi8vJXM6JWQvJnF1b3Q7ICUgKGhvc3QsIHBvcnQpLDxicj4NCiZndDsgwqAgwqAgwqAgwqAg
dHJhbnNwb3J0PXQsIGFsbG93X25vbmU9VHJ1ZSk8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsg
KyDCoCDCoHMgPSB4bWxycGNsaWIuU2VydmVyUHJveHkoJnF1b3Q7aHR0cDovLyVzOiVkLyZxdW90
OyAlIChob3N0LDxicj4NCiZndDsgwqAgwqAgwqAgwqAgcG9ydCksIHRyYW5zcG9ydD10LCBhbGxv
d19ub25lPVRydWUpPGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7IMKgIMKgIMKgcmV0dXJuIHMs
IHQ8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDs8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsg
wqBjbGFzcyBCaXRCYWtlU2VydmVyQ29tbWFuZHMoKTo8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZn
dDsgQEAgLTI1MywxMyArMjUzLDE4IEBAIGNsYXNzIFhNTFJQQ1NlcnZlcihTaW1wbGVYTUxSUENT
ZXJ2ZXIsPGJyPg0KJmd0OyDCoCDCoCDCoCDCoCBCYXNlSW1wbFNlcnZlcik6PGJyPg0KJmd0OyDC
oCDCoCDCoCDCoCAmZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKgc29ja3RpbWVvdXQgPSBzZWxmLnNv
Y2tldC5nZXR0aW1lb3V0KCkgb3I8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgIG5leHRzbGVlcDxicj4N
CiZndDsgwqAgwqAgwqAgwqAgJmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoHNvY2t0aW1lb3V0ID0g
bWluKHNvY2t0aW1lb3V0LCBuZXh0c2xlZXApPGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIyBNaXJyb3Igd2hhdCBCYXNlU2VydmVyIGhhbmRsZV9yZXF1ZXN0
IHdvdWxkPGJyPg0KJmd0OyDCoCDCoCDCoCDCoCBkbzxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0
OyAtIMKgIMKgIMKgIMKgIMKgIMKgZmRfc2V0cyA9IHNlbGVjdC5zZWxlY3QoZmRzLCBbXSwgW10s
PGJyPg0KJmd0OyDCoCDCoCDCoCDCoCBzb2NrdGltZW91dCk8YnI+DQomZ3Q7IMKgIMKgIMKgIMKg
ICZndDsgLSDCoCDCoCDCoCDCoCDCoCDCoGlmIGZkX3NldHNbMF0gYW5kIHNlbGYgaW4gZmRfc2V0
c1swXTo8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsgLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHNlbGYuX2hhbmRsZV9yZXF1ZXN0X25vYmxvY2soKTxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0
OyArIMKgIMKgIMKgIMKgIMKgIMKgdHJ5Ojxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyArIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZmRfc2V0cyA9IHNlbGVjdC5zZWxlY3QoZmRzLCBbXSwgW10s
PGJyPg0KJmd0OyDCoCDCoCDCoCDCoCBzb2NrdGltZW91dCk8YnI+DQomZ3Q7IMKgIMKgIMKgIMKg
ICZndDsgKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIGZkX3NldHNbMF0gYW5kIHNlbGYgaW4g
ZmRfc2V0c1swXTo8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsgKyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHNlbGYuX2hhbmRsZV9yZXF1ZXN0X25vYmxvY2soKTxicj4NCiZndDsgwqAg
wqAgwqAgwqAgJmd0OyArIMKgIMKgIMKgIMKgIMKgIMKgZXhjZXB0IElPRXJyb3I6PGJyPg0KJmd0
OyDCoCDCoCDCoCDCoCAmZ3Q7ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAjIHdlIGlnbm9yZSBp
bnRlcnJ1cHRlZCBjYWxsczxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyArIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcGFzczxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0Ozxicj4NCiZndDsgwqAg
wqAgwqAgwqAgJmd0OyDCoCDCoCDCoCDCoCDCoCMgVGVsbCBpZGxlIGZ1bmN0aW9ucyB3ZSYjMzk7
cmUgZXhpdGluZzxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyDCoCDCoCDCoCDCoCDCoGZvciBm
dW5jdGlvbiwgZGF0YSBpbiBzZWxmLl9pZGxlZnVucy5pdGVtcygpOjxicj4NCiZndDsgwqAgwqAg
wqAgwqAgJmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoHRyeTo8YnI+DQomZ3Q7IMKgIMKgIMKgIMKg
ICZndDsgKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZxdW90O1J1bm5pbmcgaWRsZSBm
dW5jcyZxdW90OywgZnVuY3Rpb24sIGRhdGE8YnI+DQomZ3Q7PGJyPg0KJmd0Ozxicj4NCiZndDsg
wqAgwqAgwqAgwqAgRGlkIHlvdSBtZWFuIHRvIGxlYXZlIHRoaXMgaW4/PGJyPg0KJmd0Ozxicj4N
CiZndDsgwqAgwqAgwqAgwqAgQ2hlZXJzLDxicj4NCiZndDs8YnI+DQomZ3Q7IMKgIMKgIMKgIMKg
IFJpY2hhcmQ8YnI+DQomZ3Q7PGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgcmV0dmFsID0gZnVuY3Rpb24oc2VsZiwgZGF0YSwgVHJ1ZSk8YnI+DQom
Z3Q7IMKgIMKgIMKgIMKgICZndDsgwqAgwqAgwqAgwqAgwqAgwqAgwqBleGNlcHQ6PGJyPg0KJmd0
OyDCoCDCoCDCoCDCoCAmZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcGFzczxicj4NCiZn
dDsgwqAgwqAgwqAgwqAgJmd0OyBAQCAtMzQ2LDcgKzM1MSw4IEBAIGNsYXNzPGJyPg0KJmd0OyDC
oCDCoCDCoCDCoCBCaXRCYWtlWE1MUlBDQ2xpZW50KEJpdEJha2VCYXNlU2VydmVyKTo8YnI+DQom
Z3Q7IMKgIMKgIMKgIMKgICZndDsgwqAgwqAgwqAgwqAgwqAgwqAgwqBbaG9zdCwgcG9ydF0gPSBz
ZWxmLnJlbW90ZS5zcGxpdCgmcXVvdDs6JnF1b3Q7KTxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0
OyDCoCDCoCDCoCDCoCDCoCDCoCDCoHBvcnQgPSBpbnQocG9ydCk8YnI+DQomZ3Q7IMKgIMKgIMKg
IMKgICZndDsgwqAgwqAgwqAgwqAgwqBleGNlcHQgRXhjZXB0aW9uIGFzIGU6PGJyPg0KJmd0OyDC
oCDCoCDCoCDCoCAmZ3Q7IC0gwqAgwqAgwqAgwqAgwqAgwqBiYi5mYXRhbCgmcXVvdDtGYWlsZWQg
dG8gcmVhZCByZW1vdGUgZGVmaW5pdGlvbiAoJTxicj4NCiZndDsgwqAgwqAgwqAgwqAgcykmcXVv
dDsgJSBzdHIoZSkpPGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7ICsgwqAgwqAgwqAgwqAgwqAg
wqBiYi53YXJuKCZxdW90O0ZhaWxlZCB0byByZWFkIHJlbW90ZSBkZWZpbml0aW9uICglcykmcXVv
dDs8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICUgc3RyKGUpKTxicj4NCiZndDsgwqAgwqAgwqAgwqAg
Jmd0OyArIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgZTxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0
Ozxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyDCoCDCoCDCoCDCoCDCoCMgV2UgbmVlZCBvdXIg
SVAgZm9yIHRoZSBzZXJ2ZXIgY29ubmVjdGlvbi4gV2UgZ2V0PGJyPg0KJmd0OyDCoCDCoCDCoCDC
oCB0aGUgSVA8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsgwqAgwqAgwqAgwqAgwqAjIGJ5IHRy
eWluZyB0byBjb25uZWN0IHdpdGggdGhlIHNlcnZlcjxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0
OyBAQCAtMzU2LDEzICszNjIsMTUgQEAgY2xhc3M8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgIEJpdEJh
a2VYTUxSUENDbGllbnQoQml0QmFrZUJhc2VTZXJ2ZXIpOjxicj4NCiZndDsgwqAgwqAgwqAgwqAg
Jmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoGlwID0gcy5nZXRzb2NrbmFtZSgpWzBdPGJyPg0KJmd0
OyDCoCDCoCDCoCDCoCAmZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKgcy5jbG9zZSgpPGJyPg0KJmd0
OyDCoCDCoCDCoCDCoCAmZ3Q7IMKgIMKgIMKgIMKgIMKgZXhjZXB0IEV4Y2VwdGlvbiBhcyBlOjxi
cj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyAtIMKgIMKgIMKgIMKgIMKgIMKgYmIuZmF0YWwoJnF1
b3Q7Q291bGQgbm90IGNyZWF0ZSBzb2NrZXQgZm9yICVzOiVzICglPGJyPg0KJmd0OyDCoCDCoCDC
oCDCoCBzKSZxdW90OyAlIChob3N0LCBwb3J0LCBzdHIoZSkpKTxicj4NCiZndDsgwqAgwqAgwqAg
wqAgJmd0OyArIMKgIMKgIMKgIMKgIMKgIMKgYmIud2FybigmcXVvdDtDb3VsZCBub3QgY3JlYXRl
IHNvY2tldCBmb3IgJXM6JXMgKCU8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgIHMpJnF1b3Q7ICUgKGhv
c3QsIHBvcnQsIHN0cihlKSkpPGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7ICsgwqAgwqAgwqAg
wqAgwqAgwqByYWlzZSBlPGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7IMKgIMKgIMKgIMKgIMKg
dHJ5Ojxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoHNlbGYu
c2VydmVySW1wbCA9IFhNTFJQQ1Byb3h5U2VydmVyKGhvc3QsIHBvcnQpPGJyPg0KJmd0OyDCoCDC
oCDCoCDCoCAmZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VsZi5jb25uZWN0aW9uID08YnI+DQom
Z3Q7IMKgIMKgIMKgIMKgIEJpdEJha2VYTUxSUENTZXJ2ZXJDb25uZWN0aW9uKHNlbGYuc2VydmVy
SW1wbCwgKGlwLCAwKSw8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgIHNlbGYub2JzZXJ2ZXJfb25seSwg
ZmVhdHVyZXNldCk8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsgwqAgwqAgwqAgwqAgwqAgwqAg
wqByZXR1cm4gc2VsZi5jb25uZWN0aW9uLmNvbm5lY3QoKTxicj4NCiZndDsgwqAgwqAgwqAgwqAg
Jmd0OyDCoCDCoCDCoCDCoCDCoGV4Y2VwdCBFeGNlcHRpb24gYXMgZTo8YnI+DQomZ3Q7IMKgIMKg
IMKgIMKgICZndDsgLSDCoCDCoCDCoCDCoCDCoCDCoGJiLmZhdGFsKCZxdW90O0NvdWxkIG5vdCBj
b25uZWN0IHRvIHNlcnZlciBhdCAlczolczxicj4NCiZndDsgwqAgwqAgwqAgwqAgKCVzKSZxdW90
OyAlIChob3N0LCBwb3J0LCBzdHIoZSkpKTxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyArIMKg
IMKgIMKgIMKgIMKgIMKgYmIud2FybigmcXVvdDtDb3VsZCBub3QgY29ubmVjdCB0byBzZXJ2ZXIg
YXQgJXM6JXM8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICglcykmcXVvdDsgJSAoaG9zdCwgcG9ydCwg
c3RyKGUpKSk8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsgKyDCoCDCoCDCoCDCoCDCoCDCoHJh
aXNlIGU8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDs8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZn
dDsgwqAgwqAgwqBkZWYgZW5kU2Vzc2lvbihzZWxmKTo8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZn
dDsgwqAgwqAgwqAgwqAgwqBzZWxmLmNvbm5lY3Rpb24ucmVtb3ZlQ2xpZW50KCk8YnI+DQomZ3Q7
IMKgIMKgIMKgIMKgICZndDsgZGlmZiAtLWdpdCBhL2xpYi9iYi91aS91aWV2ZW50LnB5IGIvbGli
L2JiL3VpL3VpZXZlbnQucHk8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsgaW5kZXggOTg2NThm
Ni4uZWI3NjBjMCAxMDA2NDQ8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsgLS0tIGEvbGliL2Ji
L3VpL3VpZXZlbnQucHk8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsgKysrIGIvbGliL2JiL3Vp
L3VpZXZlbnQucHk8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsgQEAgLTQ3LDcgKzQ3LDggQEAg
Y2xhc3MgQkJVSUV2ZW50UXVldWU6PGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7IMKgIMKgIMKg
IMKgIMKgc2VsZi5FdmVudEhhbmRsZSA9PGJyPg0KJmd0OyDCoCDCoCDCoCDCoCBzZWxmLkJCU2Vy
dmVyLnJlZ2lzdGVyRXZlbnRIYW5kbGVyKHNlbGYuaG9zdCwgc2VsZi5wb3J0KTxicj4NCiZndDsg
wqAgwqAgwqAgwqAgJmd0Ozxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyDCoCDCoCDCoCDCoCDC
oGlmIChzZWxmLkV2ZW50SGFuZGxlID09IE5vbmUpOjxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0
OyAtIMKgIMKgIMKgIMKgIMKgIMKgYmIuZmF0YWwoJnF1b3Q7Q291bGQgbm90IHJlZ2lzdGVyIFVJ
IGV2ZW50IGhhbmRsZXImcXVvdDspPGJyPg0KJmd0OyDCoCDCoCDCoCDCoCAmZ3Q7ICsgwqAgwqAg
wqAgwqAgwqAgwqBiYi53YXJuKCZxdW90O0NvdWxkIG5vdCByZWdpc3RlciBVSSBldmVudCBoYW5k
bGVyICU8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgIHM6JWQmcXVvdDsgJSAoc2VsZi5ob3N0LCBzZWxm
LnBvcnQpKTxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyArIMKgIMKgIMKgIMKgIMKgIMKgcmFp
c2UgRXhjZXB0aW9uKCZxdW90O0NvdWxkIG5vdCByZWdpc3RlciBVSSBldmVudDxicj4NCiZndDsg
wqAgwqAgwqAgwqAgaGFuZGxlciZxdW90Oyk8YnI+DQomZ3Q7IMKgIMKgIMKgIMKgICZndDs8YnI+
DQomZ3Q7IMKgIMKgIMKgIMKgICZndDsgwqAgwqAgwqAgwqAgwqBzZWxmLnNlcnZlciA9IHNlcnZl
cjxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0Ozxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyAt
LTxicj4NCiZndDsgwqAgwqAgwqAgwqAgJmd0OyAxLjkuMTxicj4NCiZndDsgwqAgwqAgwqAgwqAg
Jmd0Ozxicj4NCiZndDs8YnI+DQomZ3Q7PGJyPg0KJmd0Ozxicj4NCiZndDs8YnI+DQomZ3Q7PGJy
Pg0KJmd0Ozxicj4NCiZndDs8YnI+DQomZ3Q7IC0tPGJyPg0KJmd0OyBBbGV4IERhbWlhbjxicj4N
CiZndDsgWW9jdG8gUHJvamVjdDxicj4NCiZndDs8YnI+DQomZ3Q7IFNTRyAvIE9UQzxicj4NCjxi
cj4NCjxicj4NCjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PGJyIGNsZWFyPSJh
bGwiPjxkaXY+PGJyPjwvZGl2Pi0tIDxicj48ZGl2IGRpcj0ibHRyIj5BbGV4IERhbWlhbjxkaXY+
WW9jdG8gUHJvamVjdDxicj48L2Rpdj48ZGl2PlNTRyAvIE9UQ8KgPC9kaXY+PC9kaXY+DQo8L2Rp
dj4NCg==

--001a113344606953d404fb039713--
