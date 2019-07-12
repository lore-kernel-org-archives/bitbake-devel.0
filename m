Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 30ACB7F0D7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 08:13:48 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id z1so8924986wru.13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 01:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=0r1n7vvEgkLxxqu/dRMDWneHJQORc5cmOZmSKLXIWhY=;
	b=PlFBzxcxqDVEEIX0BxiAAOJ3DwPnIoz3SUgID391ciArHv6HLUvxeD+vmYxC0QtfDy
	Dv5NDDDCNJ7qqIZCyeqRO4ZWimgYDILiJ5FahFMbitAzhriPajACijbNe80lsJnVRR49
	LHxD/MGptDf6FVXTjdQ+1pE4En+t9Bdi1uhPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=0r1n7vvEgkLxxqu/dRMDWneHJQORc5cmOZmSKLXIWhY=;
	b=lR2K5/vvk0hk7Sh8Xf998ZBL5EUaj/mIctJ3IY8PgY5eIZM8tDa24iGdxGHmreGmSc
	AkK7SBNAoyzgnaBRh3Vu40IQFm+VuCk/hNPkxXq7RbmfoSe2JwlDSt94vxyY4IiIoltA
	QgKAq6c+n82PnYqFjHoH+cSiOiDLUaoXvSHO5LU0ZE3KnxK331z188Jut6+XBvaLcRsL
	4rhimnqUGKyp0ayHCHk/4lmJ/puSFSE3vTh2WStL6iM6nDjdoLlfFFRhc5uMG2s6UD1g
	h2Ag5bHTMQA23DPt1d0pCRrVDPkYvVyLF76+HdGrCIiLbVOJact421WquL7i1IP2nl68
	YLkA==
X-Gm-Message-State: APjAAAVLDlpjkXa6+ZjnUZ3/FnmeZ2b6WJmzbftaMOTwyCiguaGxpo7Q
	9cdGmxDB6rDjgAgusIbta7UkVQ==
X-Google-Smtp-Source: APXvYqzcM5wV8ljdgecMxwf9AJgyOl4k7RG8vdAQTg0RtLstJi+u+AwE3iEmRcXdIKWfveIK1o0I8w==
X-Received: by 2002:adf:e841:: with SMTP id d1mr10301773wrn.204.1562919228964; 
	Fri, 12 Jul 2019 01:13:48 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id g8sm7463711wmf.17.2019.07.12.01.13.48
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 12 Jul 2019 01:13:48 -0700 (PDT)
Message-ID: <6a89042251ee14aa63722cd202618dc70da36f87.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Khem Raj <raj.khem@gmail.com>
Date: Fri, 12 Jul 2019 09:13:47 +0100
In-Reply-To: <CAMKF1srFj=bqwA3V4JUFX-eLuDfPxjpgU8d55PG+CxbE4j=c2g@mail.gmail.com>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
	<8ace64fd460c657fee23dd39887825e418314c5e.camel@linuxfoundation.org>
	<e09869e803d875b3dfc9ba329dc261550bb25143.camel@linuxfoundation.org>
	<CAMKF1srFj=bqwA3V4JUFX-eLuDfPxjpgU8d55PG+CxbE4j=c2g@mail.gmail.com>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 00/26] runqueue changes
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
X-List-Received-Date: Fri, 12 Jul 2019 08:13:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Khem,

On Thu, 2019-07-11 at 17:57 -0700, Khem Raj wrote:
> Hi Richard
> 
> Good changes I believe. Can you push them to a temp branch on bitbake
> repo ?

They're in master-next!

Cheers,

Richard


