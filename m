Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4478.1793966687416337389
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Nov 2026 04:04:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=OSo3AjZV;
 spf=pass (domain: gmail.com, ip: 209.85.222.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-990a39ba4fbso109828241.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 06 Nov 2026 04:04:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793966686; cv=none;
        d=google.com; s=arc-20260327;
        b=mkUC7bHtJ2lUsG+9wRnGG28VJ2mgoxVM51lZ+ov0MQEs6kh7MpUEPPzmJTPSzXQ4Aq
         /agEAvUdScUJBCG5bOf7X7DmQW+tND52L4cD8ZKi7fJC6m31nGlabu4XpXGWmxQplLQh
         10ZdDYkwgvOLc5H89TvU4HQQnRfXqLcp6rzG410E0n57yJCoO6RLgQWZt/v44VK6EoJi
         ucaEWc5CuceWxv0ETC5Jb8psrgw6Btu0MyK+C2MNwGPVBbYTcWe8uXkGSBt5lfD2gnaN
         1Qtcgv+gcaOhvksMnmV7EMF+bKRAp07pG5QRr73I1J0GuGrx6adhHz9A/lpJsxBnwaeU
         Veug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=o2KJRP7o9OEaBwenhmTGz6i9ltU1EFZgFtwstSUQcsM=;
        fh=94jClH+uUQZF8aeBtwYui2L3QSbbLL0FYnTmsB/gAD8=;
        b=Uaiqp/tKmAB1tnbibDKC56U1pSjIcJyMoeIjxZuG/prMoOGldyPdeSk47ZMKp2606M
         LG8lA0nd6IC9tTOUzXXfKBOnzXZw54svNjXfXC5YvbD2FYyDIH4ozN4WHayYsN6bZjJO
         alI6aFnH3lzG7qDy+Ktr52QDeK0BKGiL1V1+RufUJz4TQ00qGcANUPdqRI0v+2GqiGcG
         U/rtRzyXElmk7BAPH0I61xCPyX/Vu0ZfdewwTuuvPM4kWwefm/xdP6aaIOIxwDTv2KiD
         wWBD6YlEIjo4IG39RKEeju5g7kAsR/VWyZIG+v/+QoU4V7qFqsz3BacD0/ZdOPCsnaZa
         XLhw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793966686; x=1794571486; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o2KJRP7o9OEaBwenhmTGz6i9ltU1EFZgFtwstSUQcsM=;
        b=OSo3AjZVRiORnaI1G3zH6JDJs8uEiOzc53pVqX1sYS6darK1g7eiMUAS0VZPSm8glo
         AJoK7gNb69+TRrEBk19M63YISAc4H8QtiGs2cLZSb+ZTFMyZfVMTPjh0dpW9YtlL7VXW
         FhGyAHNw1314mxzED8sNNqI53Dx+TpFr4fBHs1ngb88ySx30pURfrO9w4V6T+/4NIbET
         V5aIr93iwdaxBy+PpsBknsJTIQpk1W2CkhWipyJtKVkiJhJwX9VrCeJXRvBQaJYUaSH4
         eZmb/XTObVPb7oGFd+3e0cgMTqdmA2kp8qeee/0Dh1xxE9wRMcUBKtukD5bxqOsicyPx
         lKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793966686; x=1794571486;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o2KJRP7o9OEaBwenhmTGz6i9ltU1EFZgFtwstSUQcsM=;
        b=m1WM2xJNGAK/yOs4WVesDa/r9AXzEOMOLphyEyUvz1Q+k0KAfo51dZb1x+q+VIxu+S
         FxTM9tyMp7funNV/l0LgwYXf9SBGHvzcP7fkKfaWY/D3leXEcGzxBtNiwgb5sFKF0vM6
         E0JU/UZgApzoHECqV/3Zgj0Roa5oa9G3NMOf70dDuGeMblA8znW+myNlAYnyk0IbdgKo
         ED/z2pDXTp+C4uaw6OytqezNvfm3Tx+qnDCawdraBloyGRTVBxryTR9Pan0uK7A5gVnS
         40cYB9rXAZ8/QXCK1OX6yKu4xy3PfJOisYQBSpMjfNB8P2k19tSWysQyFL8A6w5Gec2K
         zkjQ==
X-Forwarded-Encrypted: i=1; AKwUvByb51uw61+0GXqK36D7/9tiZ5c8ZmmncQ4uVM71oj7DoC3/9oKRgBHHpQDsUjVA3XilSza/4K1TMugcrIPT@lists.openembedded.org
X-Gm-Message-State: APuU4Z/N8uhKVDeF6bmuPs8soVxEboowxUaClHAAt7mIR5gcKN5w5EIE
	QpGQDcKXKBy7/ECPmEOaZyPRB6CIFO6rUFhYt70loLf9pe71tlGCIVQYL+cztfc6RWS5HxILk2n
	iyg9pBfDeidDm64/oqUOx441qVKr3SpQ=
X-Gm-Gg: AYBFou3ZGddZspHiBtdgik52yp2QZBU1pyDF8tODRZ0hDj6zfdSo0I+nR4uZq3tKIZf
	hUJP/LYCj8jI9O1zBtJtSmdrkaDYQqLtH4GS62pfORgrFipn0a4xl2d/sXu3CoiBd7IVb3fwa0e
	kqjeA3a8QobjnZ7wM2G7DAzBlRbhU2teuRMgR9bltPj7QQ8WIvg40tZ0eXDe1ew21PT1rmZP8DB
	nseERy8Wo32kODAF5UXFmOxJoAJ1MlvRofUHMlD48YfgvAIsry8iMPKaE3pr8mD2PCeHiWfoKND
	XofBVLAmYIG1ONdHthLFgCF2ZqD3lE5frRMcUZFQz6RU/hRhJMfCA6aOSqmlE09kEARpDVwTXuR
	ywBAJYcn7h6SR08lvTqcDx8hKb27wbly4Ga3QH6OxLis+lb+xyW4pMvDza5CuM7Vm+fO1vlc=
X-Received: by 2002:a05:6102:f14:b0:7b3:7653:5487 with SMTP id
 ada2fe7eead31-7d2a16b4f28mr1126157137.32.1793966686139; Fri, 06 Nov 2026
 04:04:46 -0800 (PST)
MIME-Version: 1.0
References: <CANNYZj9=G4+jmRx7UJMYbsp2xwDxwSmm+Gv2HxcPJtOen_9LUA@mail.gmail.com>
 <20261105210554.1648512-1-stondo@gmail.com>
In-Reply-To: <20261105210554.1648512-1-stondo@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 6 Nov 2026 13:04:34 +0100
X-Gm-Features: AclHuK9H7LVGnDfflIrbOAITin1kQ1OP5mbFYaoatTsO8Ed8ifaFjpU6IXRxSBU
Message-ID: <CANNYZj9-JNh8uRFWFMZRwnsNy1_dN+_OEDLA2NN3Z8smAKBRdg@mail.gmail.com>
Subject: Re: [RFC] spdx30: name, version and purl for dependency downloads
To: Stefano Tondo <stondo@gmail.com>
Cc: openembedded-core@lists.openembedded.org, 
	bitbake-devel@lists.openembedded.org, Joshua Watt <JPEWhacker@gmail.com>, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
	Peter Marko <peter.marko@siemens.com>, Adrian Freihofer <adrian.freihofer@siemens.com>, 
	Patrick Wicki <patrick.wicki@siemens.com>, stefano.tondo.ext@siemens.com
Content-Type: multipart/alternative; boundary="00000000000010f910065f9a6b45"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 06 Nov 2026 12:04:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20402

--00000000000010f910065f9a6b45
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Nov 2026 at 22:05, Stefano Tondo <stondo@gmail.com> wrote:

> Yocto already knows all of this at fetch time; the RFC is only about
> writing it into the SPDX it already produces, without changing how
> anything is fetched. I hope that makes the context clearer, and I am
> happy to go into more detail on any of it.
>

Hello Stefano,

thanks for the detailed response. I need to look at code to give specific
guidance, but I want to make a couple general points:

- do not make fetchers any more complex than they already are. The reason
is that few people understand or have an interest in that code, even fewer
are able to meaningfully review contributions to it. And still fewer
actually show up to patch review meetings where patches are looked at.
Rather try to do as much as possible in oe-core through a clear API.

- gitsm and npmsw are historical mistakes, however 'convenient' they may
be. Doing internal magic just resulted in a ton of corner cases,
maintenance headaches and (in case of npm) bitrot and lack of integrity
protection that caused the whole thing to be disabled until that disabling
forced someone to fix the issues. I would want to replace them with flat,
explicit implementations.

Alex

--00000000000010f910065f9a6b45
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, 5 Nov 2026 at 22:05, Stefano Tond=
o &lt;<a href=3D"mailto:stondo@gmail.com">stondo@gmail.com</a>&gt; wrote:</=
div><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
Yocto already knows all of this at fetch time; the RFC is only about<br>
writing it into the SPDX it already produces, without changing how<br>
anything is fetched. I hope that makes the context clearer, and I am<br>
happy to go into more detail on any of it.<br></blockquote><br></div><div c=
lass=3D"gmail_quote gmail_quote_container">Hello Stefano,</div><div class=
=3D"gmail_quote gmail_quote_container"><br></div><div class=3D"gmail_quote =
gmail_quote_container">thanks for the detailed response. I need to look at =
code to give specific guidance, but I want to make a couple general points:=
</div><div class=3D"gmail_quote gmail_quote_container"><br></div><div class=
=3D"gmail_quote gmail_quote_container">- do not make fetchers any more comp=
lex than they already are. The reason is that few people understand or have=
 an interest in that code, even fewer are able to meaningfully review contr=
ibutions to it. And still fewer actually show up to patch review meetings w=
here patches are looked at. Rather try to do as much as possible in oe-core=
 through a clear API.</div><div class=3D"gmail_quote gmail_quote_container"=
><br></div><div class=3D"gmail_quote gmail_quote_container">- gitsm and npm=
sw are historical mistakes, however &#39;convenient&#39; they may be. Doing=
 internal magic just resulted in a ton of corner cases, maintenance headach=
es and (in case of npm) bitrot and lack of integrity protection that caused=
 the whole thing to be disabled until that disabling forced someone to fix =
the issues. I would want to replace them with flat, explicit implementation=
s.</div><div class=3D"gmail_quote gmail_quote_container"><br></div><div cla=
ss=3D"gmail_quote gmail_quote_container">Alex</div></div>

--00000000000010f910065f9a6b45--
