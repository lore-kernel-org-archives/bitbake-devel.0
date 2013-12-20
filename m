Return-Path: <nicolas.dechesne@linaro.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
	[209.85.214.179])
	by mail.openembedded.org (Postfix) with ESMTP id 3E7126007C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Dec 2013 09:54:58 +0000 (UTC)
Received: by mail-ob0-f179.google.com with SMTP id wm4so2474612obc.10
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Dec 2013 01:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=RTNGfoZC1EU+7p1y3OBAEgsE2s9SUZJlrFJ+82iVEhc=;
	b=J3IMuWgwnblSKzu1eHOoZE4EevpkwShZdJBffvLD7Ncew/2kcotAHDey67P/9VnPU2
	QpY8ZLpdL/MszIgXPhmxf5unsSRLflGL42oDmFBZ2iCCh4RAVkWIZPiFhFI9WzbEQChh
	xxIvd5rYQg2eUiWVWcepVwqi89cye0EcYP+8NtmstEzisBEjPJGlAH7eIN/6jgHrS5Bq
	lNkiRbMHkVxSybfMfssOCDPDwk6axXD9EeQkJErfWOttoo9AavHeMuAE8Ic0juDJr/3o
	VVqWzeWulHIqjimKDyv9WXlZ7b9x6xYgEL62w4M/6wykoJM0XSBz9H+l8kVcTW+s1D2v
	+ROQ==
X-Gm-Message-State: ALoCoQkmvElsuqsSDmhT+H9nziEub+rBtYys6SomtbwzhBD1rfJi/ur1ca98vNyHCJROLvNhF+Wr
X-Received: by 10.60.74.37 with SMTP id q5mr5583041oev.3.1387533299016; Fri,
	20 Dec 2013 01:54:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.122.81 with HTTP; Fri, 20 Dec 2013 01:54:38 -0800 (PST)
In-Reply-To: <CAJ7NSKrbE9XAN=B+KWY5RD31q-3wwJtX9xdkuyN9QLLq=iUSPg@mail.gmail.com>
References: <CAJ7NSKrbE9XAN=B+KWY5RD31q-3wwJtX9xdkuyN9QLLq=iUSPg@mail.gmail.com>
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Fri, 20 Dec 2013 10:54:38 +0100
Message-ID: <CAP71WjyxC+ScMoCCjct9uaLraktZbkPb-_EC=wAFkFxgonGp_Q@mail.gmail.com>
To: Udayan Bapat <uvbapat@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Regarding CFLAGS in recipe
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
X-List-Received-Date: Fri, 20 Dec 2013 09:54:59 -0000
Content-Type: multipart/alternative; boundary=001a1135f7bc67036d04edf445ba

--001a1135f7bc67036d04edf445ba
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Nov 7, 2013 at 9:31 PM, Udayan Bapat <uvbapat@gmail.com> wrote:

> Hi all,
>
> I have a Yocto build environment where I intend to build all recipes with
> -fPIE flag. So I have added CFLAGS_append += '-fPIE' in the local.conf.
> However since shared libraries can not be built using -fPIE flag, I would
> like to remove it from some recipes.
>
> So far I have tried this in .bb files -
>
> CFLAGS_noPIE = "${@'${CFLAGS}'.replace('-fPIE','')}"
>
> do_compile_prepend () {
>     CFLAGS = "${CFLAGS_noPIE}"
> }
>
> This throws an error -
>
> */zlib-native/1.2.8-r0/temp/run.do_compile.23159: line 82: CFLAGS: command
> not found
>
> I also have tried -
>
> CFLAGS = "${@'${CFLAGS}'.replace('-fPIE','')}"
>
> This doesn't work because same variable can not be referenced twice.
>
> Then I tried this -
>
> CFLAGS_noPIE = "${@'${CFLAGS}'.replace('-fPIE','')}"
> CFLAGS = "${CFLAGS_noPIE}"
>
> This fails with an error "maximum recursion depth exceeded for variable
> 'CFLAGS'"
>
> What is the correct way to doing this?
>

if you use 'master' you can use the newly added _remove modifier. e.g.
CFLAGS_remove = "-fPIE"

otherwise you might need to query the DB to retrieve CFLAGS, something
along these lines: ${@d.getVar('CFLAGS', True).replace(xxx)}

--001a1135f7bc67036d04edf445ba
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Nov 7, 2013 at 9:31 PM, Udayan Bapat <span dir=3D"ltr">&lt;<a href=
=3D"mailto:uvbapat@gmail.com" target=3D"_blank">uvbapat@gmail.com</a>&gt;</=
span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div><div>Hi all,<br><br>I have a Yocto build environment =
where I intend to build all recipes with -fPIE flag. So I have added CFLAGS=
_append +=3D &#39;-fPIE&#39; in the local.conf. However since shared librar=
ies can not be built using -fPIE flag, I would like to remove it from some =
recipes.<br>


<br>So far I have tried this in .bb files - <br><br>CFLAGS_noPIE =3D &quot;=
${@&#39;${CFLAGS}&#39;.replace(&#39;-fPIE&#39;,&#39;&#39;)}&quot;<br><br>do=
_compile_prepend () {<br>=A0=A0=A0 CFLAGS =3D &quot;${CFLAGS_noPIE}&quot;<b=
r>}<br>


<br></div>This throws an error - <br><br>*/zlib-native/1.2.8-r0/temp/run.do=
_compile.23159: line 82: CFLAGS: command not found<br><br></div>I also have=
 tried - <br><br>CFLAGS =3D &quot;${@&#39;${CFLAGS}&#39;.replace(&#39;-fPIE=
&#39;,&#39;&#39;)}&quot;<br>


<br><div><div>This doesn&#39;t work because same variable can not be refere=
nced twice.<br><br></div><div>Then I tried this - <br><br>CFLAGS_noPIE =3D =
&quot;${@&#39;${CFLAGS}&#39;.replace(&#39;-fPIE&#39;,&#39;&#39;)}&quot;<br>


</div><div>CFLAGS =3D &quot;${CFLAGS_noPIE}&quot; </div><div><br></div><div=
>This fails with an error &quot;maximum recursion depth exceeded for variab=
le &#39;CFLAGS&#39;&quot;<br><br></div><div>What is the correct way to doin=
g this?</div>

</div></blockquote></div><br>if you use &#39;master&#39; you can use the ne=
wly added _remove modifier. e.g. CFLAGS_remove =3D &quot;-fPIE&quot;</div><=
div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">otherwise yo=
u might need to query the DB to retrieve CFLAGS, something along these line=
s: ${@d.getVar(&#39;CFLAGS&#39;, True).replace(xxx)}</div>

<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><br></div><=
/div>

--001a1135f7bc67036d04edf445ba--
