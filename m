Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3478ACCF9E3
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 12:07:08 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15756.1762862823169101321
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 04:07:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=au4lJXG4;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso1248731f8f.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 04:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762862821; x=1763467621; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0BVKGzw/LDiEaovTI3j652hHCNXE07/m2bBwjBLjUlQ=;
        b=au4lJXG44uj28TR8FOUuxO29PEQu1g8b4NTEyiz7HgPKa7hb+MZ9BWdz2mJplCDW4N
         E4uwh5T5EOmOA8xQjFt92cJnDF6fIEc3nCl+/BIAR8k82I4AObx9V7c3bILL++Putzjz
         GfijgED5yujxorAgn2T6LcDCAvdHdoLcxJcNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762862821; x=1763467621;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0BVKGzw/LDiEaovTI3j652hHCNXE07/m2bBwjBLjUlQ=;
        b=R1UzRona147KRTqa+uta0T3BAx+xmbHI9BZWkLRB1IIdVDXhSCgiD6v7vV+d0u7SXl
         0lcRuzH8+g4V2lEyoVgh+TWKu6e9nyagMiahY3ece4cFw1KpHnwLzfv0SmN3ylb/fbiS
         ObluAP6ukaBDVUJ+yEFIY6pxbmGY5HrkhlMsm1ntitStl3z+JCZMhEa92HoSxcX2374Q
         jQveDu8a7o5Nq0udLypxo9Uzo9K0jvub0WHp65mjw3NI4qx+c3our71ayvdSuhMpIrHN
         +PWqhVnb+tVO3rfWk9KJen24n2Fr1Mw5h08w5u/NOzTiEEgjEzScoQZ2dLzdAG6Q8Jvm
         L8bw==
X-Forwarded-Encrypted: i=1; AJvYcCV1ij7DJS3bxRYXg5nWqYA6tr+j9SZ7qdGgxeGzvojKs9bawKgvxZ8PToe03WYzH3kMSRZEKhlwrLMykXQU@lists.openembedded.org
X-Gm-Message-State: AOJu0YxC39sFVdONZKljac90Y416Dd4vz/JnewK0y3GBGTFj7hNc2Eo4
	gHZxfh1pcUVyXjqj4nGn86MClDHdd7fm5lyBDRfgYXl7MMi7/XiZv+s3mO567ImYnkjA3X721PC
	OGCZe
X-Gm-Gg: ASbGnctw02M7j7odN1TqI/QquOhz/0DpA6wHBf1+NmhyP2ZQywFP2UkcAImHzSMBnwc
	P3EHqlcxn6m8bwxy2pVv4j111cVPDEUtzFaG6QuCFLEsVXB6d7tLLcTNWYVuvN8FiENiKHtmbZX
	xrNHjsoS6KAlMtICYaje1IB6G6EV0JBGU20TsY9jyG6FRf7AP3yXm2xISIbkwPKhNjSbJkrUBfd
	BS7jNbKE1x6zSNK6sITAJXI4X+xc3CqXGIsC4Yj4BKvylgydIv30vRDUA+k5KrVLQz/jykcBDdH
	2A+q2zg7ai+SqXS4CT6cdmXbFWjnq2SFlFrxBEnmT3cBJkxhPhUC+KmY4djyTQz8De1E7Z49FVd
	dykigYXyUwcL0NlcTR9VZhwEbiA0m/Gtyihx9V0hNLoYvUuyVo+ANvSqPvG8TiMkBBUAFwp8Juj
	cTfBtScAISTKv4thJ5SJDeeJsY3WQ6Pk044fwVJYmN0g7P/9+K7kbCG0qUt5Evi0Of
X-Google-Smtp-Source: AGHT+IGsEVERFiybIiT5yVOh1nl9sD5fSc8GFaP+A9tCEgqkScC3IoxnOf8wRX6iT6T6A7VDXFTV/A==
X-Received: by 2002:a5d:5f83:0:b0:429:b5a8:5c65 with SMTP id ffacd0b85a97d-42b2dc825famr9181320f8f.30.1762862821328;
        Tue, 11 Nov 2025 04:07:01 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:e5b4:de25:c1b8:e4ca? ([2001:8b0:aba:5f3c:e5b4:de25:c1b8:e4ca])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679c5dcsm31373678f8f.44.2025.11.11.04.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:07:00 -0800 (PST)
Message-ID: <29595a8ed6b004a981a82b14abf8e60592b14777.camel@linuxfoundation.org>
Subject: YP 5.3 Release readiness - not there yet
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: openembedded-architecture
	 <openembedded-architecture@lists.openembedded.org>, openembedded-core
	 <openembedded-core@lists.openembedded.org>, bitbake-devel
	 <bitbake-devel@lists.openembedded.org>
Date: Tue, 11 Nov 2025 12:06:59 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 12:07:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18320

Having gone through trying to use bitbake-setup again, I'm sad to say
that this isn't ready yet.

The basic structure is there and is good but it has significant rough
edges that cause usability problems and putting this in front of new or
existing users is going to do the project reputation harm.

I don't mind rough edges, but not when they're at the level they're
currently at.

I appreciate saying this instantly puts the pressure on me to say
why/where it has issues and how to fix them. I will try and provide
some thoughts on that but I am pretty burnt out at this point and not
at my best. It is frustrating that I'm the one having to say this and
that in saying it, I just make things worse for myself but it is what
needs to be done.

I had hoped more eyes, working through the docs and so on would let us
get through this but as yet, that hasn't happened. I don't think we can
release until we're in a better state.

Sorry,

Richard




