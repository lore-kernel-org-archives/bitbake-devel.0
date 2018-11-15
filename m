Return-Path: <stefanb.linux@gmail.com>
Received: from mail-yw1-f54.google.com (mail-yw1-f54.google.com
	[209.85.161.54])
	by mail.openembedded.org (Postfix) with ESMTP id D58146079E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Nov 2018 08:27:39 +0000 (UTC)
Received: by mail-yw1-f54.google.com with SMTP id h32so2299374ywk.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Nov 2018 00:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=0LIYHx4ebLwULjPSZx3RjDL4nRw0Ui92Cpb3ZpjY2eU=;
	b=PNgnFGpq24Ii9cxdIu4ED5aCXLonhw1gp3eo+emGRkQHz7LPMItokjxhoFRPo1pfYh
	LrQfxxbVLUFpw0KhOOSZZwsTGBZZVOxFh6YrWBukvlOoO4+cRWrwWCuO1accHFlfy+PS
	F3tj9j8Xur6ZkrKNNszi2zt6l0Ml6k4ffmbbT0Z8kLITUFVW6ex/2jq0DL+/ydivtKLJ
	E1Kb5o3zGwKKHP5EBFXDFb92V2orG7Frmq6X1pdhBVWvWrCsAzjVh7lKaQQwS6ybtZzS
	9CUv/p9iKk4fjzGbOYJe3Ar8QA/7kD0FUhxP8zClpCVsXGb1KeVfYSNbvi7oYTazyWHD
	+O3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=0LIYHx4ebLwULjPSZx3RjDL4nRw0Ui92Cpb3ZpjY2eU=;
	b=Kf97Q9wj8wNFoS4V65NkdzTJbIiF5/A8LFydtEXcr1HaloEoc/lBnYNLLeJIMG8dXo
	wlGJJSGH8bkQmpzzLADcyBurOod9VDG33QGjlhceT3UapYXGSgDriT1yaOBKg+nkoUv9
	yx8UxWYagP/GRPZuO2eOdke4iyWeDycwGR88OcmizPf+UVVZ8PJPTykL6sPNVK7o6Gym
	UhM7WVIYoTqm2WY1gtPW1++m37AaFwK6b45mc9LGIW1Czt9rTke8SKDMpSsXDo6p8u9T
	klTCti6I+MbO7wRLHdlcCl0YFqIB73x2ItbhsjCf6HsY5a7j5AAIcZDdTTrxZ9v19IHQ
	fjpg==
X-Gm-Message-State: AGRZ1gIEpWu53PRRLiQfjKnn9QoUZFft3ZQ2upZCKkTeRA/1uw2YnCFk
	g4v5fQpL8POcbYe3kIGytNPQ+5+rJyhA6tY/rqOZGUs3
X-Google-Smtp-Source: AJdET5cdgkpc/dgAjrbXjEpEr5UHeKdeaIZyL+2RHZGa0R5rae+ZIa/zNymxLyUXpiYMQQaK0or51iW/HLldxbVnWhA=
X-Received: by 2002:a81:4c97:: with SMTP id
	z145-v6mr5008722ywa.131.1542270460552; 
	Thu, 15 Nov 2018 00:27:40 -0800 (PST)
MIME-Version: 1.0
From: Stefan Bigler <stefanb.linux@gmail.com>
Date: Thu, 15 Nov 2018 09:27:29 +0100
Message-ID: <CAJPUqK17vRq6YfcgzB+S6px4nPQNb=zM0XrXA-7DkV864dU3zw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: gitsm fetching fails
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
X-List-Received-Date: Thu, 15 Nov 2018 08:27:40 -0000
Content-Type: multipart/alternative; boundary="000000000000f2eba0057aafd2fe"

--000000000000f2eba0057aafd2fe
Content-Type: text/plain; charset="UTF-8"

Hi Mark

Thank you for the explanation and sorry for the late response from my side.
With your help I was successful.

> On 11/11/18 3:04 PM, Stefan Bigler wrote:
> > Hi
> > I'm updating from rocko to thud and recognized, that my projects with
> > git-submodules cannot be fetched anymore.
> > I tried to debug the fetch task, but I failed. I did a small example
you should
> > have access and it should be easy to reproduce, the repo should be
public.
> > The recipe works fine with rocko but fails with the latest master
branch of poky.
> > I'm using gitlab for my repos. When I use https it works also with
thud, only
> > when *ssh* is used then it fails.
> > Below you find the recipe, the console output and the important part of
the
> > log.do_fetch
> > I hope somebody can give me a hint.

> The previous fetcher handed off everything to git and did not do all of
the
> validation and network caching/fetching like it should have.  This hid a
lot of
> problems and prevented the system from being able to use declared mirror
resources.
>
> The new fetcher iterates over the items and calls the regular git fetcher
to
> pull down the various components.  This ensures that the download
directory and
> mirrors are used appropriately.
>
> Below the message:

> > ERROR: gitsm-test-1.0+gitAUTOINC+5e400c09b7-r0 do_fetch: The URL:
> > 'gitsm:Bigler/gitsm-test-submodule.git;protocol=git at gitlab.com

> indicates that the submodule is not defined properly.  If this is legal,
then it
> may require some kind of a translation that does not exist.

> See: http://git.openembedded.org/bitbake/tree/lib/bb/fetch2/gitsm.py

> Look at lines 86 though 96.  This is where the submodule URLs are
constructed.
> The current code is expected the submodules to be defined with URIs, NOT
SSH
> 'strings'.

> i.e.:
> http://user@host/path/file
> ssh://user@host/path/file
> NOT
> user at host:path/file

> It appears that this submodule reference is using the second format,
instead of
> the actual URI format.  gitlab must be doing something different if it
works on
> http but not ssh, since typically the .gitmodules are declared in a
singular
> format by the author of the repository and don't change, even if the fetch
> method of the initial repository changes.

If I change the .gitmodules to

[submodule "lib"]
    path = lib
-    url =       git@gitlab.com:gitsm/gitsm-test-submodule.git
+    url = ssh://git@gitlab.com/gitsm/gitsm-test-submodule.git

then it works as expected

> Since you have a way to reproduce this, I'd suggest working through that
small
> section of code and trying to determine if it's an invalid URI (SSH
style) and
> then translating it to a URI for this processing.  (If you can make a
reproducer
> publicly available, then I can try to fix it instead.)

The repos are available here
https://gitlab.com/gitsm/gitsm-test/tree/master

> Looking at the git.py, it says the following protocols are supported:
> "git", "http", "https", "file", "ssh" and "rsync"

> So checking the protocol field for one of those, failing it find it
should go
> into a translation step most likely.  The result (I would assume) will
either be
> file or ssh.  If there is a ':', then most likely it's an ssh.. and the
rules to
> make this into a proper URI should be fairly simple.

With the patch below I *hardcoded* the gitlab format and it works as well,
but of course all other will fail.
I do not know if there is a good way to detect if secondary format is used
and then do the conversion.
Anyway, I can live with the standard format and I can change it in my repos.

bitbake/lib/bb/fetch2/gitsm.py
@@ -88,8 +88,17 @@ class GitSM(Git):
             module_hash = module_hash.split()[2]

             # Build new SRC_URI
-            proto = uris[module].split(':', 1)[0]
-            url = uris[module].replace('%s:' % proto, 'gitsm:', 1)
+            proto = "ssh"
+            url   = "gitsm://"
+            url  += uris[module].replace(':', '/', 1)
+
             url += ';protocol=%s' % proto

-- Stefan

--000000000000f2eba0057aafd2fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Mark<br><br>Thank you for the explanation and sorry for=
 the late response from my side.<br>With your help I was successful.<br><br=
>&gt; On 11/11/18 3:04 PM, Stefan Bigler wrote:<br>&gt; &gt; Hi<br>&gt; &gt=
; I&#39;m updating from rocko to thud and recognized, that my projects with=
<br>&gt; &gt; git-submodules cannot be fetched anymore.<br>&gt; &gt; I trie=
d to debug the fetch task, but I failed. I did a small example you should<b=
r>&gt; &gt; have access and it should be easy to reproduce, the repo should=
 be public.<br>&gt; &gt; The recipe works fine with rocko but fails with th=
e latest master branch of poky.<br>&gt; &gt; I&#39;m using gitlab for my re=
pos. When I use https it works also with thud, only<br>&gt; &gt; when *ssh*=
 is used then it fails.<br>&gt; &gt; Below you find the recipe, the console=
 output and the important part of the<br>&gt; &gt; log.do_fetch<br>&gt; &gt=
; I hope somebody can give me a hint.<br><br>&gt; The previous fetcher hand=
ed off everything to git and did not do all of the<br>&gt; validation and n=
etwork caching/fetching like it should have.=C2=A0 This hid a lot of<br>&gt=
; problems and prevented the system from being able to use declared mirror =
resources.<br>&gt;<br>&gt; The new fetcher iterates over the items and call=
s the regular git fetcher to<br>&gt; pull down the various components.=C2=
=A0 This ensures that the download directory and<br>&gt; mirrors are used a=
ppropriately.<br>&gt;<br>&gt; Below the message:<br><br>&gt; &gt; ERROR: gi=
tsm-test-1.0+gitAUTOINC+5e400c09b7-r0 do_fetch: The URL:<br>&gt; &gt; &#39;=
gitsm:Bigler/gitsm-test-submodule.git;protocol=3Dgit at <a href=3D"http://g=
itlab.com">gitlab.com</a><br><br>&gt; indicates that the submodule is not d=
efined properly.=C2=A0 If this is legal, then it<br>&gt; may require some k=
ind of a translation that does not exist.<br><br>&gt; See: <a href=3D"http:=
//git.openembedded.org/bitbake/tree/lib/bb/fetch2/gitsm.py">http://git.open=
embedded.org/bitbake/tree/lib/bb/fetch2/gitsm.py</a><br><br>&gt; Look at li=
nes 86 though 96.=C2=A0 This is where the submodule URLs are constructed.<b=
r>&gt; The current code is expected the submodules to be defined with URIs,=
 NOT SSH<br>&gt; &#39;strings&#39;.<br><br>&gt; i.e.:<br>&gt; http://user@h=
ost/path/file<br>&gt; ssh://user@host/path/file<br>&gt; NOT<br>&gt; user at=
 host:path/file<br><br>&gt; It appears that this submodule reference is usi=
ng the second format, instead of<br>&gt; the actual URI format. =C2=A0gitla=
b must be doing something different if it works on<br>&gt; http but not ssh=
, since typically the .gitmodules are declared in a singular<br>&gt; format=
 by the author of the repository and don&#39;t change, even if the fetch<br=
>&gt; method of the initial repository changes.<br><br>If I change the .git=
modules to<br><br>[submodule &quot;lib&quot;]<br>=C2=A0 =C2=A0 path =3D lib=
<br>- =C2=A0 =C2=A0url =3D =C2=A0 =C2=A0 =C2=A0 git@gitlab.com:gitsm/gitsm-=
test-submodule.git<br>+ =C2=A0 =C2=A0url =3D ssh://<a href=3D"http://git@gi=
tlab.com/gitsm/gitsm-test-submodule.git">git@gitlab.com/gitsm/gitsm-test-su=
bmodule.git</a><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>then it works as expected=
<br>=C2=A0 =C2=A0<br>&gt; Since you have a way to reproduce this, I&#39;d s=
uggest working through that small<br>&gt; section of code and trying to det=
ermine if it&#39;s an invalid URI (SSH style) and<br>&gt; then translating =
it to a URI for this processing. =C2=A0(If you can make a reproducer<br>&gt=
; publicly available, then I can try to fix it instead.)<br><br>The repos a=
re available here<br><a href=3D"https://gitlab.com/gitsm/gitsm-test/tree/ma=
ster">https://gitlab.com/gitsm/gitsm-test/tree/master</a><br><br>&gt; Looki=
ng at the git.py, it says the following protocols are supported:<br>&gt; &q=
uot;git&quot;, &quot;http&quot;, &quot;https&quot;, &quot;file&quot;, &quot=
;ssh&quot; and &quot;rsync&quot;<br><br>&gt; So checking the protocol field=
 for one of those, failing it find it should go<br>&gt; into a translation =
step most likely.=C2=A0 The result (I would assume) will either be<br>&gt; =
file or ssh.=C2=A0 If there is a &#39;:&#39;, then most likely it&#39;s an =
ssh.. and the rules to<br>&gt; make this into a proper URI should be fairly=
 simple.<br><br>With the patch below I *hardcoded* the gitlab format and it=
 works as well, but of course all other will fail.<br>I do not know if ther=
e is a good way to detect if secondary format is used and then do the conve=
rsion.<br>Anyway, I can live with the standard format and I can change it i=
n my repos.<br><br>bitbake/lib/bb/fetch2/gitsm.py<br>@@ -88,8 +88,17 @@ cla=
ss GitSM(Git):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0module_ha=
sh =3D module_hash.split()[2]<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0# Build new SRC_URI<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0proto =3D uris[module].split(&#39;:&#39;, 1)[0]<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D uris[module].replace(&#39;%s:&#39; %=
 proto, &#39;gitsm:&#39;, 1)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
proto =3D &quot;ssh&quot;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url=
 =C2=A0 =3D &quot;gitsm://&quot;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0url =C2=A0+=3D uris[module].replace(&#39;:&#39;, &#39;/&#39;, 1)<br>+=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url +=3D &#39;;protocol=
=3D%s&#39; % proto<br><br>-- Stefan<br></div>

--000000000000f2eba0057aafd2fe--
