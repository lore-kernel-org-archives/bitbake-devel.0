Return-Path: <ross.burton@intel.com>
Received: from mail-it0-f43.google.com (mail-it0-f43.google.com
	[209.85.214.43])
	by mail.openembedded.org (Postfix) with ESMTP id 94E5A78211
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Aug 2017 11:32:51 +0000 (UTC)
Received: by mail-it0-f43.google.com with SMTP id v127so23118681itd.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Aug 2017 04:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=FJ0GpMWyk/Z9ufGNAl4wfEY1X7fjve0bTOvWm/nmsDE=;
	b=KRBbTE096TYvgiM2Ahm3G+pag2QSA65KlX4TO5EkwqHhdPig/GSPxxvCaZdYeOWbDH
	N4RPEmCV7siaYO4C01RnlRTsE4lklfwptH5HkgJHZ5mOjYNK3oCAyJQYSSQ2vQXs3Kpi
	C3txHgvCrZ0f8yLu2EhC5CbNX8BFUZNxSCMMz9y1I6TcXZTTc2/nBP1WcskVvD3MOp2t
	kok9nxGY2JtHuXKQ5yYe6Y7/tzR02zGm7qjeCPSaLsWT+St89a/RPg+xqMSgeedSiNOt
	o7xIbefvNq2uPUs93l1nl2UyZ40REcMgEGW43wW3LjpXboY8NpdsjwlCAd6xpl4CiL9T
	YlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=FJ0GpMWyk/Z9ufGNAl4wfEY1X7fjve0bTOvWm/nmsDE=;
	b=MEq1nCJcwhlVyOFTKfvqr+m/i9ZcZ3p3dEDUAqYq2bCIFtqV7AKh1R3XFGJXcJolAj
	djA8CKCpPkm/SWrhGQE6ZBN2ZdqnBio7SL4usubS+M943trIIBFUkf292XmKfbEAjFr6
	XWJcRTvCThVaa9TFwQ3GF/zRRk9POM093yg8id+pq9PP6aWUvXCMi+qKLNprksycUwti
	vOmKYkH83BBKlww7u7Xrx3RNzZaAlQ3bOHtulbUjfkAhUqtsOzCYdFcMOwLU8JMAXUAK
	Iza3mwj52sDBmR8QH/evgS+cfbMabTDVbdmjqPxBb3BSLR0/nmz4BrvL7exhgJ7rQqMF
	fbqA==
X-Gm-Message-State: AIVw113cxt8XnIhNezjN+hNC6EL890byOnjhNmgE4R64ip/1Sk6caFvp
	8+rOF/DCtgKkZHC2xxZxO+uKjzOkeQ7x
X-Received: by 10.36.154.67 with SMTP id l64mr5008367ite.87.1501673572744;
	Wed, 02 Aug 2017 04:32:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.135.234 with HTTP; Wed, 2 Aug 2017 04:32:31 -0700 (PDT)
In-Reply-To: <1501667264-32012-1-git-send-email-mikko.rapeli@bmw.de>
References: <1501667264-32012-1-git-send-email-mikko.rapeli@bmw.de>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Wed, 2 Aug 2017 12:32:31 +0100
Message-ID: <CAJTo0LawBBCPg73-fuEXoe354MiacxdM37mZQqRrc0izCQt0Jw@mail.gmail.com>
To: Mikko Rapeli <mikko.rapeli@bmw.de>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/git.py: try to handle local clone failures by pruning branches
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
X-List-Received-Date: Wed, 02 Aug 2017 11:32:51 -0000
Content-Type: multipart/alternative; boundary="94eb2c11489edf56850555c39fca"

--94eb2c11489edf56850555c39fca
Content-Type: text/plain; charset="UTF-8"

On 2 August 2017 at 10:47, Mikko Rapeli <mikko.rapeli@bmw.de> wrote:

> +            except bb.fetch2.FetchError:
> +                # try to recover by pruning deleted remote branches which
> +                # make cloning local git tree fail in git 2.7.x but not in
> +                # git 1.9.x
> +                try:
> +                    runfetchcmd("%s -C %s remote prune origin" %
> (ud.basecmd, ud.clonedir), d)
> +                except bb.fetch2.FetchError:
> +                    pass
>

Would it be best to simplify the logic by aways pruning before fetching?
Prune doesn't take a long time, and it will keep the size of the mirror
down.

Ross

--94eb2c11489edf56850555c39fca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On 2 August 2017 at 10:47, Mikko Rapeli <span dir=3D"ltr">=
&lt;<a href=3D"mailto:mikko.rapeli@bmw.de" target=3D"_blank">mikko.rapeli@b=
mw.de</a>&gt;</span> wrote:<div class=3D"gmail_extra"><div class=3D"gmail_q=
uote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except bb.fetch2.FetchError:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # try to recover b=
y pruning deleted remote branches which<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # make cloning loc=
al git tree fail in git 2.7.x but not in<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # git 1.9.x<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runf=
etchcmd(&quot;%s -C %s remote prune origin&quot; % (ud.basecmd, ud.clonedir=
), d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except bb.fetch2.F=
etchError:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pass=
<br></blockquote><div><br></div><div>Would it be best to simplify the logic=
 by aways pruning before fetching?=C2=A0 Prune doesn&#39;t take a long time=
, and it will keep the size of the mirror down.</div><div><br></div><div>Ro=
ss=C2=A0</div></div></div></div>

--94eb2c11489edf56850555c39fca--
