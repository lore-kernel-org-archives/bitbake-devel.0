Received: from mga07.intel.com ([143.182.124.22] helo=azsmga101.ch.intel.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bogdan.a.marinescu@intel.com>) id 1TyJ9y-0001qi-BJ
	for bitbake-devel@lists.openembedded.org;
	Thu, 24 Jan 2013 10:31:52 +0100
Received: from mail-ob0-f198.google.com ([209.85.214.198])
	by mga03.intel.com with ESMTP/TLS/RC4-SHA; 24 Jan 2013 01:15:11 -0800
Received: by mail-ob0-f198.google.com with SMTP id dn14so1550202obc.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Jan 2013 01:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=x-received:x-received:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type:x-gm-message-state;
	bh=S08IBkbdCoLTfY/u9nsT0T5jHU5FAzTcaQZ+zF6eL8E=;
	b=ajx0oH6lzeizP0imXhNXiZ9eVJkrZ1e0EBYw1moqk+7Wcmg1o5m27neKYfB3W4fndh
	Hu1UMcEJp4OYGnQMZVi/GZHfdyewbSKx4xTDhPg4ANYC2LZ0XCG3xSwAcFpTF+eMFYIM
	c4ucxNAI68SoO3DFhXAImBe+Dj/7DjXqJkMKNAltbW75HcWM/YjAFQRKV+qJUv5ksG6R
	2axpKOLXZ0XKetVohqE347zO1+npsPQZUGkAQ+jdpvohfDMF3HihXM7n6zUPpjX5Ha5/
	/jyAG03+SZ9bn41Xsx+4rM1HtEnG2RWB2JDm9l2J8ZzwWQnub5en2KXoWDywUgu8+++b
	QXQg==
X-Received: by 10.182.136.68 with SMTP id py4mr918171obb.38.1359018909988;
	Thu, 24 Jan 2013 01:15:09 -0800 (PST)
X-Received: by 10.182.136.68 with SMTP id py4mr918164obb.38.1359018909861;
	Thu, 24 Jan 2013 01:15:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.5.4 with HTTP; Thu, 24 Jan 2013 01:14:48 -0800 (PST)
In-Reply-To: <1358954088.6356.61.camel@ted>
References: <CAMZjud1sM6e2Rd2tWsBjt_XJ7N9J6AZo5OJg+R6q47AXwdg_3A@mail.gmail.com>
	<1358954088.6356.61.camel@ted>
From: "Marinescu, Bogdan A" <bogdan.a.marinescu@intel.com>
Date: Thu, 24 Jan 2013 11:14:48 +0200
Message-ID: <CAMZjud3pCy_moAvKy+zyGSt+Q76Pt-dMOmKLhJga5vGEQ=n-xA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
X-Gm-Message-State: ALoCoQlJ4zhVir9scokdwB1kkUmMZWzaky0DGLKIhUTlWeijSEgIByyGZ4sWhP74FCAebUcDYbFjDfCtX2tywJTA60ksP/Dh60xeiYX9RnZqKFs0QXGQ428ugPsceAlwdhpgN9kvqdMbCl7Dh1m7RF/W/fID11XCmJGN2kSqK2dr3utG4OwT44y5UXJzQJ6xwgQIwJh+Kg/z
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: RFC: bugfix for 3575
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
X-List-Received-Date: Thu, 24 Jan 2013 09:31:52 -0000
Content-Type: multipart/alternative; boundary=e89a8f6479035d86b704d4053f55

--e89a8f6479035d86b704d4053f55
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Jan 23, 2013 at 5:14 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2013-01-23 at 12:08 +0200, Marinescu, Bogdan A wrote:
> > Please review my fix of bug 3575 (Ensure windows hob client
> > communication with bitbake backend via xmlrpc). I'd like to get
> > feedback before uploading the patches. I've pushed my fix on
> > poky-contrib:
> >
> http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=bogdanm/b3575
> >
> > Currently, the fix allows bitbake and hob to run on different machines
> > and "talk" to each other via XMLRPC (no windows version yet, but it
> > can be tested in Linux). Hopefully the commit messages will tell the
> > rest of the story.
>
> First two commits are no problem.
>
> Third Commit:
>
> I don't like the merging of all the extra cache data. I think when a
> given UI registers, it needs to call into cooker and inform bitbake it
> requires the extra caches (if it does so). With your current code, we
> might as well throw away the extra cache code as it effectively works as
> the greatest set. I see this only happens in server mode but I'm still
> not 100% convinced its the right thing to do.
>

I considered that. It would have been the most generic and elegant
solution, but I decided against it mainly because currently only Hob uses
an extra cache (and judging from its size, it doesn't appear to incur a
large speed and/or memory penalty), which didn't seem to compensate for the
amount of work needed to implement the extra-caches-load-on-demand feature.
Plus, if we go for the load-on-demand, we'll probably want to implement
unload-on-exit (when the client exits and the caches aren't needed anymore)
for completion, which adds even more complexity. That said, I can start
working on this if you think it is the right way to do.


>
> I also don't see why knotty can't work in server mode?
>

I added my thoughts on that in the bug description page, I'll copy/paste
them here:

=========================================================================================================

> There is no good reason knotty shouldn't work with a remote server over
> xmlrpc?

There are a few that I've found. The main problem comes from the fact
that the server is initialized like this:

    server = server.BitBakeServer()
    if configuration.bind:
        server.initServer((configuration.bind, 0))
    else:
        server.initServer()

    idle = server.getServerIdleCB()

    cooker = bb.cooker.BBCooker(configuration, idle, initialenv)
    cooker.parseCommandLine()

    server.addcooker(cooker)
    server.saveConnectionDetails()
    server.detach()

As you can see, parseCommandLine is called when the server is
initialized. If we switch to client/server model, the command line on
the client side won't be taken into account, since it's not ever
parsed. Fortunately, this is fairly easy to fix (by moving the command
line parsing on the client side).
The real problem, which is related to the one above, comes from
dealing with conf/local.conf. This is parsed early in the cooker
(loadConfigurationData) and again, the cooker is "linked" with the
server and initialized at server creation time. Even if we add a
"reparseConfigurationData" method to the cooker, if the client
'bitbake' is started from a different build directory, we need access
to that build's directory conf/ files. Hob works differently in this
respect, since the user sets the required configuration data in the
interface and then Hob calls setVariable on the server, thus setting
the proper configuration. Of course, this can be done with knotty or
any other user interface too, but it definitely needs some work and
should probably be the subject of another bug.

=========================================================================================================


>
> Fourth Commit:
>
> I have a strong opinion that we want to support multiple clients
> connected to one server. I appreciate this complicates things and
> currently would be chaotic. I think the easiest way to deal with this is
> to have some notion of a single "controller" which would perhaps be
> represented by the token. We'd then have some kind of handoff process so
> that a given UI could claim the token and then control the server. We
> might be able to lose the need for the manual reclaim option too if we
> can tie this to the registered handlers somehow?
>
> Any thoughts on that approach?
>

I've considered this too, but I dismissed it quickly. I admit that my
knowledge about bitbake/hob is still pretty basic and that must have scared
me away, but still, there are some hard questions to be answered here. What
happens if there is one server connected to two clients simultaneously,
each client with its own set of configuration variables? When we switch
from one client to the other, we'd need to "reset" the server to use the
configuration variables of this last client. In fact, we probably need to
restore the full previous _state_ of this specific server/client
combination, which might be more than just the configuration variables.
Implementing this would probably take considerable effort, but even if we
do it, will it be worth from a performance standpoint? It seems like a lot
of time and memory would be spend in these save/restore state operations.
Of course, the problem will get progressively worse as the number of
clients increases.
I had a different idea for this: leave bitbake alone and implement a
"meta-server". In short, this meta-server would be a service listening on a
specific port on the build machine. The meta-server keeps a "pool" of
bitbake servers running on the build machine. The bitbake servers are
separate processes, bound to separate build directories, but configured to
share as much data as possible (shared state, downloads and everything else
that can be shared). When the meta-server receives a request from a client,
it would:

1. check if a bitbake server from its server pool is available (idle).
2. if not, create a new bitbake server (properly set to share data as
described above). Add this sever to the server pool.
3. the result of steps 1 or 2 above will be a free bitbake server, ready to
be connected to the client, so the meta-server will pass the host/port data
of the bitbake server to the client, so they can talk directly.
4. when the client finishes, it sends a "release server" request to the
meta-server, which will mark the server as "idle" (and maybe restart it to
reset its internal state? not sure if this is needed).

To add knotty into the picture, step 3 above might be augmented with a file
transfer step that would send the whole "conf/local.conf" directory on the
client side to the (meta-) server. The server would then receive the
client's configuration, interpret it, ignore what needs to be ignored
(mostly the variables used to share various data with the other bitbake
servers on the build machine) and start the build.
This is still quite a bit of work, but for someone with my basic level of
understanding of the bitbake internals it sounds much easier to implement.
For me, this is conceptually like chosing between modifying Python to
remove its GIL restrictions versus simply using multiprocessing for fixing
a problem that can be fixed with both approaches.

Thanks,
Bogdan


On Wed, Jan 23, 2013 at 5:14 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2013-01-23 at 12:08 +0200, Marinescu, Bogdan A wrote:
> > Please review my fix of bug 3575 (Ensure windows hob client
> > communication with bitbake backend via xmlrpc). I'd like to get
> > feedback before uploading the patches. I've pushed my fix on
> > poky-contrib:
> >
> http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=bogdanm/b3575
> >
> > Currently, the fix allows bitbake and hob to run on different machines
> > and "talk" to each other via XMLRPC (no windows version yet, but it
> > can be tested in Linux). Hopefully the commit messages will tell the
> > rest of the story.
>
> First two commits are no problem.
>
> Third Commit:
>
> I don't like the merging of all the extra cache data. I think when a
> given UI registers, it needs to call into cooker and inform bitbake it
> requires the extra caches (if it does so). With your current code, we
> might as well throw away the extra cache code as it effectively works as
> the greatest set. I see this only happens in server mode but I'm still
> not 100% convinced its the right thing to do.
>
> I also don't see why knotty can't work in server mode?
>
> Fourth Commit:
>
> I have a strong opinion that we want to support multiple clients
> connected to one server. I appreciate this complicates things and
> currently would be chaotic. I think the easiest way to deal with this is
> to have some notion of a single "controller" which would perhaps be
> represented by the token. We'd then have some kind of handoff process so
> that a given UI could claim the token and then control the server. We
> might be able to lose the need for the manual reclaim option too if we
> can tie this to the registered handlers somehow?
>
> Any thoughts on that approach?
>
> Cheers,
>
> Richard
>
>
>
>
>
>

--e89a8f6479035d86b704d4053f55
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br>On Wed, Jan 23, 2013 at 5:14 PM, Richard Purdie=A0<span dir=3D"ltr">&lt=
;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">ri=
chard.purdie@linuxfoundation.org</a>&gt;</span>=A0wrote:<br><div class=3D"g=
mail_quote">

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On Wed, 2013-01-23=
 at 12:08 +0200, Marinescu, Bogdan A wrote:<br>

&gt; Please review my fix of bug 3575 (Ensure windows hob client<br>&gt; co=
mmunication with bitbake backend via xmlrpc). I&#39;d like to get<br>&gt; f=
eedback before uploading the patches. I&#39;ve pushed my fix on<br>&gt; pok=
y-contrib:<br>

&gt;<a href=3D"http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?=
h=3Dbogdanm/b3575" target=3D"_blank">http://git.yoctoproject.org/cgit/cgit.=
cgi/poky-contrib/log/?h=3Dbogdanm/b3575</a><br>&gt;<br>&gt; Currently, the =
fix allows bitbake and hob to run on different machines<br>

&gt; and &quot;talk&quot; to each other via XMLRPC (no windows version yet,=
 but it<br>&gt; can be tested in Linux). Hopefully the commit messages will=
 tell the<br>&gt; rest of the story.<br><br></div></div>First two commits a=
re no problem.<br>

<br>Third Commit:<br><br>I don&#39;t like the merging of all the extra cach=
e data. I think when a<br>given UI registers, it needs to call into cooker =
and inform bitbake it<br>requires the extra caches (if it does so). With yo=
ur current code, we<br>

might as well throw away the extra cache code as it effectively works as<br=
>the greatest set. I see this only happens in server mode but I&#39;m still=
<br>not 100% convinced its the right thing to do.<br></blockquote><div>

<br></div><div>I considered that. It would have been the most generic and e=
legant solution, but I decided against it mainly because currently only Hob=
 uses an extra cache (and judging from its size, it doesn&#39;t appear to i=
ncur a large speed and/or memory penalty), which didn&#39;t seem to compens=
ate for the amount of work needed to implement the extra-caches-load-on-dem=
and feature. Plus, if we go for the load-on-demand, we&#39;ll probably want=
 to implement unload-on-exit (when the client exits and the caches aren&#39=
;t needed anymore) for completion, which adds even more complexity. That sa=
id, I can start working on this if you think it is the right way to do.=A0<=
/div>

<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left=
-style:solid;padding-left:1ex"><br>I also don&#39;t see why knotty can&#39;=
t work in server mode?<br>

</blockquote><div><br></div><div>I added my thoughts on that in the bug des=
cription page, I&#39;ll copy/paste them here:</div><div><br></div><div>=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D</div>

<div><pre class=3D"bz_comment_text" id=3D"comment_text_3"><span class=3D"qu=
ote">&gt; There is no good reason knotty shouldn&#39;t work with a remote s=
erver over
&gt; xmlrpc?</span>

There are a few that I&#39;ve found. The main problem comes from the fact t=
hat the server is initialized like this:

    server =3D server.BitBakeServer()
    if configuration.bind:
        server.initServer((configuration.bind, 0))
    else:
        server.initServer()

    idle =3D server.getServerIdleCB()

    cooker =3D bb.cooker.BBCooker(configuration, idle, initialenv)
    cooker.parseCommandLine()

    server.addcooker(cooker)
    server.saveConnectionDetails()
    server.detach()

As you can see, parseCommandLine is called when the server is initialized. =
If we switch to client/server model, the command line on the client side wo=
n&#39;t be taken into account, since it&#39;s not ever parsed. Fortunately,=
 this is fairly easy to fix (by moving the command line parsing on the clie=
nt side).
The real problem, which is related to the one above, comes from dealing wit=
h conf/local.conf. This is parsed early in the cooker (loadConfigurationDat=
a) and again, the cooker is &quot;linked&quot; with the server and initiali=
zed at server creation time. Even if we add a &quot;reparseConfigurationDat=
a&quot; method to the cooker, if the client &#39;bitbake&#39; is started fr=
om a different build directory, we need access to that build&#39;s director=
y conf/ files. Hob works differently in this respect, since the user sets t=
he required configuration data in the interface and then Hob calls setVaria=
ble on the server, thus setting the proper configuration. Of course, this c=
an be done with knotty or any other user interface too, but it definitely n=
eeds some work and should probably be the subject of another bug.</pre>

</div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-c=
olor:rgb(204,204,204);border-left-style:solid;padding-left:1ex">

<br>Fourth Commit:<br><br>I have a strong opinion that we want to support m=
ultiple clients<br>connected to one server. I appreciate this complicates t=
hings and<br>currently would be chaotic. I think the easiest way to deal wi=
th this is<br>

to have some notion of a single &quot;controller&quot; which would perhaps =
be<br>represented by the token. We&#39;d then have some kind of handoff pro=
cess so<br>that a given UI could claim the token and then control the serve=
r. We<br>

might be able to lose the need for the manual reclaim option too if we<br>c=
an tie this to the registered handlers somehow?<br><br>Any thoughts on that=
 approach?<br></blockquote><div><br></div><div>I&#39;ve considered this too=
, but I dismissed it quickly. I admit that my knowledge about bitbake/hob i=
s still pretty basic and that must have scared me away, but still, there ar=
e some hard questions to be answered here. What happens if there is one ser=
ver connected to two clients simultaneously, each client with its own set o=
f configuration variables? When we switch from one client to the other, we&=
#39;d need to &quot;reset&quot; the server to use the configuration variabl=
es of this last client. In fact, we probably need to restore the full previ=
ous _state_ of this specific server/client combination, which might be more=
 than just the configuration variables. Implementing this would probably ta=
ke considerable effort, but even if we do it, will it be worth from a perfo=
rmance standpoint? It seems like a lot of time and memory would be spend in=
 these save/restore state operations. Of course, the problem will get progr=
essively worse as the number of clients increases.</div>

<div>I had a different idea for this: leave bitbake alone and implement a &=
quot;meta-server&quot;. In short, this meta-server would be a service liste=
ning on a specific port on the build machine. The meta-server keeps a &quot=
;pool&quot; of bitbake servers running on the build machine. The bitbake se=
rvers are separate processes, bound to separate build directories, but conf=
igured to share as much data as possible (shared state, downloads and every=
thing else that can be shared). When the meta-server receives a request fro=
m a client, it would:</div>

<div><br></div><div>1. check if a bitbake server from its server pool is av=
ailable (idle).=A0</div><div>2. if not, create a new bitbake server (proper=
ly set to share data as described above). Add this sever to the server pool=
.</div>

<div>3. the result of steps 1 or 2 above will be a free bitbake server, rea=
dy to be connected to the client, so the meta-server will pass the host/por=
t data of the bitbake server to the client, so they can talk directly.</div=
>

<div>4. when the client finishes, it sends a &quot;release server&quot; req=
uest to the meta-server, which will mark the server as &quot;idle&quot; (an=
d maybe restart it to reset its internal state? not sure if this is needed)=
.</div>

<div><br></div><div>To add knotty into the picture, step 3 above might be a=
ugmented with a file transfer step that would send the whole &quot;conf/loc=
al.conf&quot; directory on the client side to the (meta-) server. The serve=
r would then receive the client&#39;s configuration, interpret it, ignore w=
hat needs to be ignored (mostly the variables used to share various data wi=
th the other bitbake servers on the build machine) and start the build.</di=
v>

<div>This is still quite a bit of work, but for someone with my basic level=
 of understanding of the bitbake internals it sounds much easier to impleme=
nt. For me, this is conceptually like chosing between modifying Python to r=
emove its GIL restrictions versus simply using multiprocessing for fixing a=
 problem that can be fixed with both approaches.</div>

<div><br></div><div>Thanks,</div><div>Bogdan</div><div><br></div></div><br>=
<div class=3D"gmail_quote">On Wed, Jan 23, 2013 at 5:14 PM, Richard Purdie =
<span dir=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org"=
 target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:=
<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On W=
ed, 2013-01-23 at 12:08 +0200, Marinescu, Bogdan A wrote:<br>
&gt; Please review my fix of bug 3575 (Ensure windows hob client<br>
&gt; communication with bitbake backend via xmlrpc). I&#39;d like to get<br=
>
&gt; feedback before uploading the patches. I&#39;ve pushed my fix on<br>
&gt; poky-contrib:<br>
&gt;<a href=3D"http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?=
h=3Dbogdanm/b3575" target=3D"_blank">http://git.yoctoproject.org/cgit/cgit.=
cgi/poky-contrib/log/?h=3Dbogdanm/b3575</a><br>
&gt;<br>
&gt; Currently, the fix allows bitbake and hob to run on different machines=
<br>
&gt; and &quot;talk&quot; to each other via XMLRPC (no windows version yet,=
 but it<br>
&gt; can be tested in Linux). Hopefully the commit messages will tell the<b=
r>
&gt; rest of the story.<br>
<br>
</div></div>First two commits are no problem.<br>
<br>
Third Commit:<br>
<br>
I don&#39;t like the merging of all the extra cache data. I think when a<br=
>
given UI registers, it needs to call into cooker and inform bitbake it<br>
requires the extra caches (if it does so). With your current code, we<br>
might as well throw away the extra cache code as it effectively works as<br=
>
the greatest set. I see this only happens in server mode but I&#39;m still<=
br>
not 100% convinced its the right thing to do.<br>
<br>
I also don&#39;t see why knotty can&#39;t work in server mode?<br>
<br>
Fourth Commit:<br>
<br>
I have a strong opinion that we want to support multiple clients<br>
connected to one server. I appreciate this complicates things and<br>
currently would be chaotic. I think the easiest way to deal with this is<br=
>
to have some notion of a single &quot;controller&quot; which would perhaps =
be<br>
represented by the token. We&#39;d then have some kind of handoff process s=
o<br>
that a given UI could claim the token and then control the server. We<br>
might be able to lose the need for the manual reclaim option too if we<br>
can tie this to the registered handlers somehow?<br>
<br>
Any thoughts on that approach?<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
<br>
<br>
<br>
</blockquote></div><br>

--e89a8f6479035d86b704d4053f55--
