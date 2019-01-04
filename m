Return-Path: <alex.kanavin@gmail.com>
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
	[209.85.167.174])
	by mail.openembedded.org (Postfix) with ESMTP id A4D9D65CE9
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Jan 2019 09:33:25 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id c206so29963087oib.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Jan 2019 01:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=6KScBUnhr2EmmyXKzc40L7jZFGJhKXplsg79uo60pdw=;
	b=u2CrV0ZhwPJajget3EnyP3qiyKOpyTv8VlRfTfxVbeRhFnDOZCmVNw4D78xF0ougX8
	xFsqK7H8ZrHf2iGjak72GfZtP7bkfECPB+ve1h1EzhfiqAUW3apPZZEcD1YzPlHVfU1E
	aR8bpuXokBYAdyeqYmhgKynL0y8Pt/6Ji1Eokg117yGUc2wyc1WweolU+LMEg6cWwSRL
	/k1dZwYJX+WG77EdwJohDHyGmmhIqT7vf2EBuA12rL8TjJQMaeU4pMqiDkKmOi7KJURj
	NE91ZEFiw5I5XASeROBcGb+t0b0MII01VHAizIPiu4c11mmFw4CHQ3PfM2Jqtep4SY2H
	8mUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=6KScBUnhr2EmmyXKzc40L7jZFGJhKXplsg79uo60pdw=;
	b=nQqJC/KnZlb6khnANPD1Rl0u7oMXYhJjoCubuRowN6jON3YGcV1wy2/83CrphI4hXJ
	w7dijuS4JEejywUrvP1jBPLTcQnYL57sxoRFBUTzQqYYiY4bo6wObJD3pzL1y9dv9iGq
	3gKmEVx+Wqb0kL2bPKjYpMKJ5zRsDcogqHYaTZvRmwWPkuP664qhxx7o2SHvVJ6GoMdn
	1lo5Hoq8CYNsUFKO5lGXyW1qMswn9MOp/uKLvgT8Fj+xq+1dOeXxJK0c6Yz9L97TC252
	AYI1TbNlJjxvApTn1jUNV4TRlNcXVoP7Mae4/nD3rctOCUgvyLZCs04FVbjrKYTXe2ec
	g/mg==
X-Gm-Message-State: AA+aEWa3wZ4FtAhXp+5AHVyc/MScsD5bD3DTzIP8FN1gDtm2dlpuBRuz
	mILQiPFS5qT1TBlhQaerZkqb/os37hAxZ2RohL0=
X-Google-Smtp-Source: ALg8bN4MjPY2+zkmTLl/nRtbuE85t7lqEGrllbNfwlJyRFXdVwR18/MhONzauT/nef7mdRZmROKsuznH+H+GzIPYZ7o=
X-Received: by 2002:aca:544:: with SMTP id 65mr32766051oif.302.1546594406680; 
	Fri, 04 Jan 2019 01:33:26 -0800 (PST)
MIME-Version: 1.0
References: <DM5PR21MB0172A8E3D4C986EF15D71AE7E58E0@DM5PR21MB0172.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB0172A8E3D4C986EF15D71AE7E58E0@DM5PR21MB0172.namprd21.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 4 Jan 2019 10:33:15 +0100
Message-ID: <CANNYZj8SuM=Mv8NA7rdhaYSGXRN18cEUfK0X9u-QNrL685yZOg@mail.gmail.com>
To: Edmund Nadolski <Edmund.Nadolski@microsoft.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Bitbake staged builds?
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
X-List-Received-Date: Fri, 04 Jan 2019 09:33:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Jan 2019 at 08:09, Edmund Nadolski via bitbake-devel
<bitbake-devel@lists.openembedded.org> wrote:
> Does bitbake support the notion of a "staged" build?  By this I mean a us=
er making an initial invocation to run a series of tasks, then subsequently=
 making a second invocation to do a second set of tasks, and so on until al=
l the tasks for a build target are completed.   The main idea is to be able=
 to run additional steps (outside of bitbake) between the invocations.  Is =
'addtask' a reasonable mechanism to implement this?

You can do it, but it would be very confusing and prone to human
errors. I recommend that you write recipes for the 'additional steps',
and use DEPENDS as needed to ensure things are run in correct order.

Alex

