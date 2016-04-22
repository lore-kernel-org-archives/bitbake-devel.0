Return-Path: <ross.burton@intel.com>
Received: from mail-io0-f173.google.com (mail-io0-f173.google.com
	[209.85.223.173])
	by mail.openembedded.org (Postfix) with ESMTP id 2BD0670101
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Apr 2016 16:06:00 +0000 (UTC)
Received: by mail-io0-f173.google.com with SMTP id 2so123514644ioy.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Apr 2016 09:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=lC9VlDFL9IKfb0Qn+Nc8rHXQO21RMyPI5Fr6JDA1BRM=;
	b=oJbPlR2PQmi4eEV40pwV30ROCeSB/Uiz9WGQDJ8uQ3Pe0Tti8/UrZU8YLnVqYpLmQD
	62i929jQvbBq25+DCH1XS3ht8zSCzQA1hqi/VkYUAxMmtlXkqRO9+MQDR/oaD97eIuQO
	7sGbeiH7vAxS5CVRnww/L/TD9882HZVDKmm++Q80OPY4Q1uVtltzJ8r/uEfPTx3IEFCe
	gVvt9+sjXP9MAvM2K+h5HDtIDd/HczblIgUqngU742p4F7J1tODhgRm0Guvx1sRnKTSR
	7Nxn0QrrmcDNMWsdrHJNdSR/wbddalJ2P1GGr4iDbBgNIdMKpzFTCqtvtSPm4zUIiKKa
	FVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=lC9VlDFL9IKfb0Qn+Nc8rHXQO21RMyPI5Fr6JDA1BRM=;
	b=DepaMnultJNA/wUa4wq7yiy0gr2W5A4+jHHc4eTjScMbM5KemZ891x0ryDrJWzjsp/
	VkaAHbqm4Kr8L/pgTExsVU8Em+8jU8cQ0DthHmg0/40ukNzvlL33QHEAsB8t+uv/zHfd
	o8LJrfuOzrDZVgds89VeeoImuvozzJfIaCQyDK09N/ElC0L0uh3diimWtVYh+3QvE1Zt
	0NlVTw/8OkHLAmYjV4xF/G6Qoror5iMtOfIGI9Br3CaVHHSZ8xEADlJUwyBwmp12k3QI
	xwt/eJ2bn8CjnNHcu/o6DR3511aqjLgOUJDPjHN3k9F3ipYH+YP6srMEMxPjvvGIy73Z
	N33w==
X-Gm-Message-State: AOPr4FV+t5+LkjmxmHjQg4/Wko7DlRcwNpCNfHSkFTpIpMxyOPcIpaUtEPVR2Gjq6CORWFjJ/tW2u3pXcVoq7dPQ
X-Received: by 10.107.51.213 with SMTP id z204mr866633ioz.148.1461341155933;
	Fri, 22 Apr 2016 09:05:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.9.106 with HTTP; Fri, 22 Apr 2016 09:05:36 -0700 (PDT)
In-Reply-To: <F6CD090A69E64C4289DC608E1C5D2024253E0CBB@DE08W1305.global.ds.honeywell.com>
References: <F6CD090A69E64C4289DC608E1C5D2024253E0CBB@DE08W1305.global.ds.honeywell.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Fri, 22 Apr 2016 17:05:36 +0100
Message-ID: <CAJTo0LZW8x_KVjOhAsp-uv3Ax5yKiKz9FxaDS-me33iF7BvcCw@mail.gmail.com>
To: "Esponde, Joel" <Joel.Esponde@honeywell.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Fetcher issue: Error communicating with gnome-keyring-daemon
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
X-List-Received-Date: Fri, 22 Apr 2016 16:06:04 -0000
Content-Type: multipart/alternative; boundary=001a11440cd07ee0b8053115004f

--001a11440cd07ee0b8053115004f
Content-Type: text/plain; charset=UTF-8

Hi Joel,

On 22 April 2016 at 10:38, Esponde, Joel <Joel.Esponde@honeywell.com> wrote:

> When bitbake tries to fetch code from a git repository that needs
> authentication whose credentials are stored in Gnome Keyring, it fails and
> produces this error:
>
>
I think what would work best is a mashup of both approaches: extracting the
variables you need from BB_ORIGINENV but injecting them into the
environment in runfetchcmd.

I don't use gnome-keyring so I can't test it, but can you see if this patch
works for you:

http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/commit/?h=ross/mut&id=60afb3b2eb222815776e8d2e13647e12def363a2

Cheers,
Ross

--001a11440cd07ee0b8053115004f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi Joel,</div><div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">On 22 April 2016 at 10:38, Esponde=
, Joel <span dir=3D"ltr">&lt;<a href=3D"mailto:Joel.Esponde@honeywell.com" =
target=3D"_blank">Joel.Esponde@honeywell.com</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-=
width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;paddin=
g-left:1ex"><p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:rgb(=
64,0,0)">When bitbake tries to fetch code from a git repository that needs =
authentication whose credentials are stored in Gnome Keyring, it fails and =
produces this error:<u></u><u></u></span></p>
<p class=3D"MsoNormal"></p></blockquote></div><br>I think what would work b=
est is a mashup of both approaches: extracting the variables you need from =
BB_ORIGINENV but injecting them into the environment in runfetchcmd.</div><=
div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">I don&#39;t =
use gnome-keyring so I can&#39;t test it, but can you see if this patch wor=
ks for you:</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_e=
xtra"><a href=3D"http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/com=
mit/?h=3Dross/mut&amp;id=3D60afb3b2eb222815776e8d2e13647e12def363a2">http:/=
/git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/commit/?h=3Dross/mut&amp;i=
d=3D60afb3b2eb222815776e8d2e13647e12def363a2</a></div><div class=3D"gmail_e=
xtra"><br></div><div class=3D"gmail_extra">Cheers,</div><div class=3D"gmail=
_extra">Ross</div></div>

--001a11440cd07ee0b8053115004f--
