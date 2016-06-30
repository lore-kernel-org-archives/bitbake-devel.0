Return-Path: <raj.khem@gmail.com>
Received: from mail-qk0-f176.google.com (mail-qk0-f176.google.com
	[209.85.220.176])
	by mail.openembedded.org (Postfix) with ESMTP id E4CD86012C;
	Thu, 30 Jun 2016 23:12:26 +0000 (UTC)
Received: by mail-qk0-f176.google.com with SMTP id j2so119917363qkf.3;
	Thu, 30 Jun 2016 16:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=YR52VGp7NMfDkZ8txxBXfGhCmyaZ8qr3zE1S5dM83IA=;
	b=PTrfxDlWDVYP0upSEehC53N0QmPOpM0OsPY1WgCH/5lbbjjSXEiRo5m5w5mgiAGj5T
	lydH9L4/4ZUeXYEyNf0a+pSSUiEb53haA1Rp+LJQl++q81mbwhwpVS7r0Or6wX9BHZFj
	W4N5zwbpWXnp17hcQtSBcPqYxYSew57eRiSvHbkB2BoP+v8UOE9CywHe0QxMTVeWeOX2
	ceI7ucamwSngJ5q0yN7AHN8ypzKxFjRCTwINYfUumx/T8K8KoqGDPfraXLb2KWBWZHh1
	3wtmZmJkLEOKFFulvk7Hxf+zBea2xN0+H4N+khV1HUKY7qUo9c+1VeI+ixqKBul2QPdS
	zqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=YR52VGp7NMfDkZ8txxBXfGhCmyaZ8qr3zE1S5dM83IA=;
	b=U6AcPGv3B0T+a703EABN984/WFyUedARRmtPhi7ihjaijv8aG5YZll0gl4bPN8AfPR
	QShCGfTr95jkQJ9luYbjtegJu9LHe0VthUOqkt8mw/fLD5O0tHgWLrcijdWNddXD60Tg
	qGxpaTb4hgjTiTXI1KjiRCGIUa14cJ/f30fTVEyPDjEJMLfEONAnpxVb0tJoZs4GuPL0
	Krnw9wH7nQwAz1hbS5aU374EV8OE37Zldg0j0cIac+cVGLTHAToE2Obj31MqoDReZVpg
	G/kZWLYEz6w99HieZ0dWXHjfuyWWpXPXTu0nPyASye8XROSPwWJy4V5DltHJ0MkRkpFK
	X8SQ==
X-Gm-Message-State: ALyK8tK79jmN5qesiu0Vwf0FCKn2GnDUg9MLEmFWlrEhd8IJgM2jMuvBw8IRyif0EodHtq4Bb/y+DbBGC4aqXQ==
X-Received: by 10.55.141.134 with SMTP id p128mr21524784qkd.102.1467328346866; 
	Thu, 30 Jun 2016 16:12:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.214.83 with HTTP; Thu, 30 Jun 2016 16:11:57 -0700 (PDT)
In-Reply-To: <ae4e2654-ca20-85d1-d53b-b0b05ab25a26@linuxfoundation.org>
References: <ae4e2654-ca20-85d1-d53b-b0b05ab25a26@linuxfoundation.org>
From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 30 Jun 2016 16:11:57 -0700
Message-ID: <CAMKF1srZ=NCMop1BWgZ9PACGJEjVguDngZT4tcAt0jqnBZt_rA@mail.gmail.com>
To: openembeded-devel <openembedded-devel@lists.openembedded.org>
Cc: "yocto@yoctoproject.org" <yocto@yoctoproject.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<Openembedded-core@lists.openembedded.org>
Subject: Re: [oe] Patchwork upgrade tonight
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
X-List-Received-Date: Thu, 30 Jun 2016 23:12:28 -0000
Content-Type: text/plain; charset=UTF-8

On Thu, Jun 30, 2016 at 4:03 PM, Michael Halstead
<mhalstead@linuxfoundation.org> wrote:
> Please reach out if you have concerns.

Hi Mike

I have been playing with the new instance no issues so far. Send a
note when you bring down the system and again another when its all up.

