Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web10.25858.1584867508420683102
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Mar 2020 01:58:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Me+3FodS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f66.google.com with SMTP id d1so10953307wmb.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 22 Mar 2020 01:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=l+R53DfUBRahAPpqHXE7bvwrHVTcMbL6sCmy0MtQ/EQ=;
        b=Me+3FodS3Q+64bYsDVskTue76LuI+W6lKvkCq06iuwDiwuDVv0Hfwfqopt055pxiuy
         /bFgyDINAfHvou49z1GyyO4U+hxIeiZzNz/HGzdpdjIZK2eMk3DMoISAEuRXUcbVP301
         zJMvrT9OjrylcafwV9e4L1WDXrzj4QsIOWqYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=l+R53DfUBRahAPpqHXE7bvwrHVTcMbL6sCmy0MtQ/EQ=;
        b=QvKc2K5EG43dMFDb/eNydfULXe9w4FLdV2srNTOvwjQp2PnO+vc1tNU+LdcA48dLFt
         BjxzkcdY4z6TXI74mj0wRYNgW5WrTEM8rf8btKnKw4u+L4mAns/YsyBc5PeKLXQXUw0x
         ePxhr+XJ70FPaMZpdorZtbuqAJDLWhEY0bUgL/PBiHHe/JyekCyWwhKSowk3FSdfatbp
         oH3WA3q6Q/ttobaWs1dpVNKmahYl+32wf3z6bYocuK7t5Dat79xMoWAcdDHl741tFFgP
         sxmXMZXydsiT37QTpVBhxMYpnuC943OokharHJchc5Uk6woI9WjQ3XlxgOtlxkQLAAo0
         aDYA==
X-Gm-Message-State: ANhLgQ2MMmGPy9ePigQ/bthG8AE3d6Gb/QP3/KR2lFRR9LKMHsnAauCb
	nzSTjtd/YMg6iFPPxu7oS532pg==
X-Google-Smtp-Source: ADFU+vtd6ld53NdrYUkU3feF2lr45/YWFXI9u2lTNdfemP1K5cinG1Wly3BQAkS5dWty6QqPQGj+IA==
X-Received: by 2002:a1c:2d03:: with SMTP id t3mr14521165wmt.137.1584867506856;
        Sun, 22 Mar 2020 01:58:26 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id u8sm17141072wrn.69.2020.03.22.01.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 01:58:26 -0700 (PDT)
Message-ID: <e7ce7de84e378f8489e9a06da5d9f7893256a987.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [master][zeus][PATCH 3/3] fetch2: Allow ${AUTOREV} to be used when BB_SRCREV_POLICY is "cache"
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, Khem Raj
	 <raj.khem@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Sun, 22 Mar 2020 08:58:23 +0000
In-Reply-To: <074d4366010e45a3b56ed7de3238fda4@XBOX03.axis.com>
References: <20200215032955.3958-3-pkj@axis.com>
	 <5532.1584827063458682607@lists.openembedded.org>
	 <1cdd50184c1f4af488baee9ee691b495@XBOX03.axis.com>
	 <CAMKF1srOQVRW8n9bzr9GXiA3NBOX=cE5EV-W9S_dq+JFRqNjMQ@mail.gmail.com>
	 <2f891d304ee448538457d2b94c32bba3@XBOX03.axis.com>
	 <CAMKF1sqsZW4Nher5wy6WwjdoWcz7-Yd-KHQyzp0PxPZsyGT=yg@mail.gmail.com>
	 <074d4366010e45a3b56ed7de3238fda4@XBOX03.axis.com>
User-Agent: Evolution 3.35.91-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2020-03-22 at 06:19 +0000, Peter Kjellerstedt wrote:
> Care to elaborate? Because I obviously do not see the usefulness in
> combining BB_SRCREV_POLICY = "cache" with ${AUTOREV} as it was
> implemented before my change.

One of the use cases this was used for was in an autobuilder
environment where a given build directory could have multiple bitbake
invocations against it and have the same src revs. Something like:

MACHINE=A bitbake X
MACHINE=B bitbake X
MACHINE=C bitbake X

and have the same revision of some AUTOREV recipe built for this
session/build directory.

Cheers,

Richard

