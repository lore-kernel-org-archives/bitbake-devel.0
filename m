Received: from mail-we0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <twoerner@gmail.com>) id 1UUKdp-0007xu-Eu
	for bitbake-devel@lists.openembedded.org;
	Mon, 22 Apr 2013 19:35:03 +0200
Received: by mail-we0-f175.google.com with SMTP id t11so6840461wey.34
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Apr 2013 10:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:in-reply-to:references:date:message-id
	:subject:from:to:cc:content-type;
	bh=+46l8Snr+cQeG89AcoUE+chfm22dXP4A5O5xGxMg9mY=;
	b=NmTJPz0Iv5vj4VERCSNmBR/2t+NVS0Ct0N2ZhG29uOcnbNyaQdl4R2/vW5LHP1CEYn
	yvyT5iChKUAqzWWL0nvRVNfxBS/ozpuoXOBS1J2zNM2sP+9FCwkhJDWCrqKNOW7SBm07
	vshOaSIDHLkdm3xmjRGvViDWJdZb1WvnO5kMi3fjNR6++tQBhU5oIzKW8szt8p23q6in
	5Tx7g75TCpca4zii2zVx3moOONnyLMXjCzKUT+3NMs3lGalT8T2W+PTCtOs80pKZ45yx
	ax0UA2x5+t/h+yFJEv0hmE3hQeuowARV124c+l/j1EjKACZB+mH8MU9YuLWWOVX+PW/+
	7m9g==
MIME-Version: 1.0
X-Received: by 10.194.10.129 with SMTP id i1mr39233906wjb.21.1366651039223;
	Mon, 22 Apr 2013 10:17:19 -0700 (PDT)
Received: by 10.194.167.73 with HTTP; Mon, 22 Apr 2013 10:17:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1304221256590.10667@oneiric>
References: <1366640172.23738.12.camel@ted>
	<CAHUNapQoJ4kOsEMZ-FB9gcSVQcU0ZcY2EfOOGcAGScvueHXHAw@mail.gmail.com>
	<alpine.DEB.2.02.1304221256590.10667@oneiric>
Date: Mon, 22 Apr 2013 13:17:19 -0400
Message-ID: <CAHUNapTg83gVx9kdXny2B7zbeso-0yS-hf=faXEEXNcYyyVmHQ@mail.gmail.com>
From: Trevor Woerner <twoerner@gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [OE-core] BitBake changes in the Yocto Project 1.5 cycle
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
X-List-Received-Date: Mon, 22 Apr 2013 17:35:04 -0000
Content-Type: multipart/alternative; boundary=047d7b5d5bd8b9970904daf63dc6

--047d7b5d5bd8b9970904daf63dc6
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Apr 22, 2013 at 12:57 PM, Robert P. J. Day <rpjday@crashcourse.ca>
wrote:
> On Mon, 22 Apr 2013, Trevor Woerner wrote:
>> On Mon, Apr 22, 2013 at 10:16 AM, Richard Purdie <rpurdie@rpsys.net>
wrote:
>> > This would then lead into the second proposal which is to add better
>> > support for new commands.
>>
>> It would be nice if there was a way to zero-in on an existing
>> environment variable. For example:
>>
>>     $ bitbake -e <image>
>>
>> produces a lot of information which I then have to parse in order to
>> figure out how a given environment variable is being set. It would be
>> nice if I could simply:
>>
>>     $ bitbake -e <image> <variable>
>>
>> and just get the pertinent parts.
>
>   i think bitbake-env would do this for you.
>
> rday

If I use bitbake-env I just get the current value:

    $ bitbake-env OE_TERMINAL
    OE_TERMINAL="screen"

but if I use "bitbake -e" I get a better pictures of why that variable is
what it is
(which I've found very useful):

    $ bitbake -e | less
    [...snip...]
    # $OE_TERMINAL [4 operations]
    #   set /home/trevor/devel/yocto/builds/fullbuild/conf/local.conf:23
    #     "screen"
    #   set?
/home/trevor/devel/yocto/git/poky/meta/classes/terminal.bbclass:1
    #     "auto"
    #   set
/home/trevor/devel/yocto/git/poky/meta/classes/terminal.bbclass:2
    #     [type] "choice"
    #   set
/home/trevor/devel/yocto/git/poky/meta/classes/terminal.bbclass:5
    #     [choices] "auto none                         ${@" ".join(o.name
                                  for o in oe.terminal.prioritized())}"
    # computed:
    #   "screen"
    OE_TERMINAL="screen"
    [...snip...]

--047d7b5d5bd8b9970904daf63dc6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Mon, Apr 22, 2013 at 12:57 PM, Robert P. J. Day &lt;<a =
href=3D"mailto:rpjday@crashcourse.ca">rpjday@crashcourse.ca</a>&gt; wrote:<=
br>&gt; On Mon, 22 Apr 2013, Trevor Woerner wrote:<br>&gt;&gt; On Mon, Apr =
22, 2013 at 10:16 AM, Richard Purdie &lt;<a href=3D"mailto:rpurdie@rpsys.ne=
t">rpurdie@rpsys.net</a>&gt; wrote:<br>
&gt;&gt; &gt; This would then lead into the second proposal which is to add=
 better<br>&gt;&gt; &gt; support for new commands.<br>&gt;&gt;<br>&gt;&gt; =
It would be nice if there was a way to zero-in on an existing<br>&gt;&gt; e=
nvironment variable. For example:<br>
&gt;&gt;<br>&gt;&gt; =A0 =A0 $ bitbake -e &lt;image&gt;<br>&gt;&gt;<br>&gt;=
&gt; produces a lot of information which I then have to parse in order to<b=
r>&gt;&gt; figure out how a given environment variable is being set. It wou=
ld be<br>
&gt;&gt; nice if I could simply:<br>&gt;&gt;<br>&gt;&gt; =A0 =A0 $ bitbake =
-e &lt;image&gt; &lt;variable&gt;<br>&gt;&gt;<br>&gt;&gt; and just get the =
pertinent parts.<br>&gt;<br>&gt; =A0 i think bitbake-env would do this for =
you.<br>
&gt;<br>&gt; rday<br><br>If I use bitbake-env I just get the current value:=
<br><br>=A0 =A0 $ bitbake-env OE_TERMINAL<br>=A0 =A0 OE_TERMINAL=3D&quot;sc=
reen&quot;<br><br>but if I use &quot;bitbake -e&quot; I get a better pictur=
es of why that variable is what it is<div>
(which I&#39;ve found very useful):<br><br>=A0 =A0 $ bitbake -e | less<br>=
=A0 =A0 [...snip...]<br>=A0 =A0 # $OE_TERMINAL [4 operations]<br>=A0 =A0 # =
=A0 set /home/trevor/devel/yocto/builds/fullbuild/conf/local.conf:23<br>=A0=
 =A0 # =A0 =A0 &quot;screen&quot;<br>
=A0 =A0 # =A0 set? /home/trevor/devel/yocto/git/poky/meta/classes/terminal.=
bbclass:1<br>=A0 =A0 # =A0 =A0 &quot;auto&quot;<br>=A0 =A0 # =A0 set /home/=
trevor/devel/yocto/git/poky/meta/classes/terminal.bbclass:2<br>=A0 =A0 # =
=A0 =A0 [type] &quot;choice&quot;<br>
=A0 =A0 # =A0 set /home/trevor/devel/yocto/git/poky/meta/classes/terminal.b=
bclass:5<br>=A0 =A0 # =A0 =A0 [choices] &quot;auto none =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ${@&quot; &quot;.join(<a href=3D"http://o.name=
">o.name</a> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 for o in oe.terminal.prioritized())}&quot;<br>
=A0 =A0 # computed:<br>=A0 =A0 # =A0 &quot;screen&quot;<br>=A0 =A0 OE_TERMI=
NAL=3D&quot;screen&quot;<br>=A0 =A0 [...snip...]</div></div>

--047d7b5d5bd8b9970904daf63dc6--
