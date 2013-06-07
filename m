Return-Path: <alexandru.damian@intel.com>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
	[209.85.219.51])
	by mail.openembedded.org (Postfix) with ESMTP id 6B87B61EEB
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jun 2013 14:49:03 +0000 (UTC)
Received: by mail-oa0-f51.google.com with SMTP id i18so551928oag.38
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 07 Jun 2013 07:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:x-gm-message-state;
	bh=VKFzTwfS/HhzJa79fSRW66enP/ixn9ddb1NQGBEkAFk=;
	b=VsI3REQIlYsVfpiNMvVZElG/QSpKG6KWdANNZSKyDNR0iIj06+hpGb2fA+HzrWjLYZ
	ZFUXMLTeosY8TFDlLxtnQm2rwooiyLmd9c0fz07XiIcQL060XMq6NTYls7O1wgfZanlH
	3rYte+EzD0NUOhZYo8BAjiLX/W2avCwaWh6JVQCRGEXl6CEK7fmY0UAHQaTT0OUGqmU0
	e7ak0LkGbv1xnzz2qOR1u9pYWBJfv1P0Q/ZzlmosxvMOvIgPW3bDhBUwtEeoU6jkiskS
	w0Oc6fN1db+zZRJQltlO/jfokznEopewYKVznJ8BHreHi5t3PpH3QEKyIY2lF4AYVXky
	Selw==
MIME-Version: 1.0
X-Received: by 10.182.134.231 with SMTP id pn7mr21273031obb.11.1370616544043; 
	Fri, 07 Jun 2013 07:49:04 -0700 (PDT)
Received: by 10.76.129.226 with HTTP; Fri, 7 Jun 2013 07:49:03 -0700 (PDT)
In-Reply-To: <CAC1BbcQQK50A8B4VL6Rt_8iOz0mT-Pi9+C+FegvAh-LQx+Ryig@mail.gmail.com>
References: <1369998409-16560-1-git-send-email-alexandru.damian@intel.com>
	<1369998409-16560-3-git-send-email-alexandru.damian@intel.com>
	<CAC1BbcQQK50A8B4VL6Rt_8iOz0mT-Pi9+C+FegvAh-LQx+Ryig@mail.gmail.com>
Date: Fri, 7 Jun 2013 15:49:03 +0100
Message-ID: <CAJ2CSBvp4Ohx+j_J2RvKevc1Hyztg7LhDntpdzmGZogLPKDtEQ@mail.gmail.com>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
X-Gm-Message-State: ALoCoQk/jnJjtdoGdjh8uE2z9JsRyBt8TBhf6D5tblEqG6C4Xh7iZy/YHSuSJJGj0MgUCidT4Gdr
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 3/4] bitbake: fixes in executable
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
X-List-Received-Date: Fri, 07 Jun 2013 14:49:03 -0000
Content-Type: multipart/alternative; boundary=001a11c2c3963b873704de91882b

--001a11c2c3963b873704de91882b
Content-Type: text/plain; charset=UTF-8

  Point taken. Unfortunately, this type of code if all over the place in
BB, so a subsequent patch will have to solve it, once we have testing
environment going on for this.

I'll add this to my list, but it is low priority. Patches welcome, though :)

Alex


On Wed, Jun 5, 2013 at 9:51 PM, Bernhard Reutner-Fischer <
rep.dot.nop@gmail.com> wrote:

> On 31 May 2013 13:06, Alex DAMIAN <alexandru.damian@intel.com> wrote:
> > From: Alexandru DAMIAN <alexandru.damian@intel.com>
> >
> > Two fixes in bitbake related to running remote servers -
> > * can now specify correctly the bind port
> > * the information in print conforms to common server infrastructure
> >
> > Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> > ---
> >  bin/bitbake | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/bin/bitbake b/bin/bitbake
> > index f3bbeb4..d263cbd 100755
> > --- a/bin/bitbake
> > +++ b/bin/bitbake
> > @@ -204,7 +204,8 @@ class
> BitBakeConfigParameters(cookerdata.ConfigParameters):
> >  def start_server(servermodule, configParams, configuration):
> >      server = servermodule.BitBakeServer()
> >      if configParams.bind:
> > -        server.initServer((configParams.bind, 0))
> > +        (host, port) = configParams.bind.split(':')
>
> [::]:1025
>
> I.e. Does that work nicely on my v6-only box or did you mean
> .rsplit(':',2) ?
> thanks,
> > +        server.initServer((host, int(port)))
> >      else:
> >          server.initServer()
> >
> > @@ -313,7 +314,7 @@ def main():
> >              bb.event.ui_queue = []
> >              server_connection.terminate()
> >      else:
> > -        print("server address: %s, server port: %s" %
> (server.serverinfo.host, server.serverinfo.port))
> > +        print("server address: %s, server port: %s" %
> (server.serverImpl.host, server.serverImpl.port))
> >
> >      return 1
> >
>

--001a11c2c3963b873704de91882b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><blockquote cite=3D"mid:CAC1BbcQQK50A8B4VL6Rt_8iOz0mT-Pi9+=
C+FegvAh-LQx+Ryig@mail.gmail.com" type=3D"cite">
  <pre></pre>
</blockquote>=C2=A0Point taken. Unfortunately, this type of code if all ove=
r the place in=20
BB, so a subsequent patch will have to solve it, once we have testing=20
environment going on for this.<br>
<br>I&#39;ll add this to my list, but it is low priority. Patches welcome, =
though :)<br><div><br></div><div style>Alex</div></div><div class=3D"gmail_=
extra"><br><br><div class=3D"gmail_quote">On Wed, Jun 5, 2013 at 9:51 PM, B=
ernhard Reutner-Fischer <span dir=3D"ltr">&lt;<a href=3D"mailto:rep.dot.nop=
@gmail.com" target=3D"_blank">rep.dot.nop@gmail.com</a>&gt;</span> wrote:<b=
r>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On 31 May 2013 13:06, Alex=
 DAMIAN &lt;<a href=3D"mailto:alexandru.damian@intel.com">alexandru.damian@=
intel.com</a>&gt; wrote:<br>

&gt; From: Alexandru DAMIAN &lt;<a href=3D"mailto:alexandru.damian@intel.co=
m">alexandru.damian@intel.com</a>&gt;<br>
&gt;<br>
&gt; Two fixes in bitbake related to running remote servers -<br>
&gt; * can now specify correctly the bind port<br>
&gt; * the information in print conforms to common server infrastructure<br=
>
&gt;<br>
&gt; Signed-off-by: Alexandru DAMIAN &lt;<a href=3D"mailto:alexandru.damian=
@intel.com">alexandru.damian@intel.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0bin/bitbake | 5 +++--<br>
&gt; =C2=A01 file changed, 3 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/bin/bitbake b/bin/bitbake<br>
&gt; index f3bbeb4..d263cbd 100755<br>
&gt; --- a/bin/bitbake<br>
&gt; +++ b/bin/bitbake<br>
&gt; @@ -204,7 +204,8 @@ class BitBakeConfigParameters(cookerdata.ConfigPar=
ameters):<br>
&gt; =C2=A0def start_server(servermodule, configParams, configuration):<br>
&gt; =C2=A0 =C2=A0 =C2=A0server =3D servermodule.BitBakeServer()<br>
&gt; =C2=A0 =C2=A0 =C2=A0if configParams.bind:<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0server.initServer((configParams.bind, 0))=
<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0(host, port) =3D configParams.bind.split(=
&#39;:&#39;)<br>
<br>
</div>[::]:1025<br>
<br>
I.e. Does that work nicely on my v6-only box or did you mean .rsplit(&#39;:=
&#39;,2) ?<br>
thanks,<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
erver.initServer((host, int(port)))<br>
&gt; =C2=A0 =C2=A0 =C2=A0else:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server.initServer()<br>
&gt;<br>
&gt; @@ -313,7 +314,7 @@ def main():<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.event.ui_queue =3D =
[]<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server_connection.term=
inate()<br>
&gt; =C2=A0 =C2=A0 =C2=A0else:<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&quot;server address: %s, server po=
rt: %s&quot; % (server.serverinfo.host, server.serverinfo.port))<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&quot;server address: %s, server po=
rt: %s&quot; % (server.serverImpl.host, server.serverImpl.port))<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0return 1<br>
&gt;<br>
</div></div></blockquote></div><br></div>

--001a11c2c3963b873704de91882b--
