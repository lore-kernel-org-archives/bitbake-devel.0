Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
	by mail.openembedded.org (Postfix) with ESMTP id 7E65078F2A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Aug 2018 09:02:18 +0000 (UTC)
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so3713580wmb.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Aug 2018 02:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=ZHmSN9mjft15x6N2fztgNrklZpBDabXG+Cl90De/uSs=;
	b=I3X1U1OK09+Q6cqqsqdQ7mjoChmlkAvZA34wV1uaCREozxHtG5Kj8+tjsAPMSNhUFp
	NU0Ie9i7suySy1/cJQRlxWCTfaZCaaFFHlahnkEAYlLGfB+hB+3O7SO+TbgJPxUNnPEV
	Y+2E9HQXByJ98QjcEQ0Nls6BoaTuMT1m6j1sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ZHmSN9mjft15x6N2fztgNrklZpBDabXG+Cl90De/uSs=;
	b=kEIXpCQ8VKkZI5Qee664CFCyVAmyKaILWMS9N5o6ZVMslu3gOA73Pd+o86DlnsqKvI
	9/ytvgCE9DMO2g0tSLCl4z+zwFImEz9PKGJWj0vUHnXHlSpRq2OA3gA3iypTz+kxk/hj
	ce0n6FHpo8HSG359s3b/RSX3mz+AHN8l7owSDW3X9qJVLZ8JXxSXytlfAHZ4j3ndZqkL
	bzwH+qefS06z7vclNuNDqHuKrUzy0kTJdZZXUpQ1+DzGuKhZvnTOSpj9jSFAgyyUvzep
	TRcwRXW8oC8RlRzGr7wxXSR0OSnMt4sTVGlREmz9bqS/GsGicAneNinsiT3dJ+35fOTw
	OLow==
X-Gm-Message-State: AOUpUlHhm7xyTISYuq597w72r9H1J6ca2JZv2+11P3lle3h5tkpv0+Qv
	HBbRYMhYXnohO+Y96f5ufLVnMAGZ2nU=
X-Google-Smtp-Source: AA+uWPwxbxLarCQZSmNDQBh0FueBeiOCGwWYWReAK/tMonSiBxUMKVOv2z17j7iyc4qr/eWsKVp6UQ==
X-Received: by 2002:a1c:5dd4:: with SMTP id
	r203-v6mr15774762wmb.29.1534410139231; 
	Thu, 16 Aug 2018 02:02:19 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	n8-v6sm18101360wrt.56.2018.08.16.02.02.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 16 Aug 2018 02:02:18 -0700 (PDT)
Message-ID: <38f67bbdeb35dbb4685177b75e8fde29f119f8f0.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 16 Aug 2018 10:02:17 +0100
In-Reply-To: <b2fac879-03f3-03f6-4746-382f319ae37b@prevas.dk>
References: <20180710120334.9609-1-rasmus.villemoes@prevas.dk>
	<52a52d2a-3f64-812b-2582-2808abaa78b5@prevas.dk>
	<62b7406a8c5edf06dccdc39acf2a5c5741e5d09e.camel@linuxfoundation.org>
	<b2fac879-03f3-03f6-4746-382f319ae37b@prevas.dk>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Subject: Re: [PATCH] bb/utils.py: add break_hardlinks helper
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
X-List-Received-Date: Thu, 16 Aug 2018 09:02:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2018-08-16 at 10:57 +0200, Rasmus Villemoes wrote:
> On 2018-08-16 10:52, richard.purdie@linuxfoundation.org wrote:
> > On Thu, 2018-08-16 at 10:38 +0200, Rasmus Villemoes wrote:
> > > On 2018-07-10 14:03, Rasmus Villemoes wrote:
> > 
> > Merged, sorry about the delay. Was there a corresponding OE-Core
> > patch?
> 
> No, I didn't think I could send such patches before this landed in
> bitbake (since any automated test would just flag those as breaking
> everything). What's the normal/proper way to handle such
> dependencies?
> On my end, I've just been running with the patches applied to the
> combined repo.

We normally bump the bitbake version, then have OE-Core depend on the
new bitbake version. Sending the patches is ok as long as you mention
the dependency clearly. 

We prefer to not have version dependency changes but sometimes it can't
be avoided...

> > Also, for new API like this we might want to consider adding some
> > tests
> > to bitbake-selftest...
> 
> I'll look into that.

Thanks!

Cheers,

Richard

