Return-Path: <ross.burton@intel.com>
Received: from mail-ve0-f173.google.com (mail-ve0-f173.google.com
	[209.85.128.173])
	by mail.openembedded.org (Postfix) with ESMTP id 93DC66D2DB
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Nov 2013 12:37:55 +0000 (UTC)
Received: by mail-ve0-f173.google.com with SMTP id c14so1271259vea.18
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 08 Nov 2013 04:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=+wPuWfuPHehXFU8/aXBJ22GI1X3h4nRJw8KLNTUt4cI=;
	b=iDNyVLEoAutneKP7OTUTQynR+lcUzcR8MyfmqqGV7To4n3pLtk34ZbeAO/ReJQsvqW
	C7XpSIUS/t5exY0jy3ia6Z3zI1UuDg08GN9Vr7oXnjp/qqMNdHngac7Ep9joSya1z4u3
	YzNoJ2UV92rRRDgofPJyuLTD0YXVwkjyLd/aINQlvqayXcuN42YL8Na5B+gtI2wiRnjW
	SEkWRnJtkBXNw5eUUCNM+qgG281R2eYVhrcWxjxi7Pl+iDfra8KAKi8T6/UwtrzhHmKf
	bpIxYATA/koR/ESYKosMYAvoO1kql9XR+W0CheiKR2DQYJr6W1SfRr6RX4+WRdQ2Ptdp
	dTFQ==
X-Gm-Message-State: ALoCoQmDBaKTr7/ZZYcyT2aF44beWImCfs4yBX9QM6+Aww0eS9Ed+OzdRRhqI1EJT4QDoqFNMgdI
X-Received: by 10.58.39.97 with SMTP id o1mr11714293vek.15.1383914277043; Fri,
	08 Nov 2013 04:37:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.220.71.201 with HTTP; Fri, 8 Nov 2013 04:37:36 -0800 (PST)
In-Reply-To: <527CD8E4.4000202@mlbassoc.com>
References: <527BAC0F.3090901@mlbassoc.com> <7286154.LbYKCCWHqH@helios>
	<527BC186.5040406@mlbassoc.com>
	<CABcZANkDuRL2bMgoy=zNbguwT6xWXw0ktDhy0KPOMZwAiS4kfg@mail.gmail.com>
	<527CD8E4.4000202@mlbassoc.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Fri, 8 Nov 2013 12:37:36 +0000
Message-ID: <CAJTo0LbPatd4dHmL5SF4x5ERZwq+A3-UKo7AT-SBNvfBrNpt5w@mail.gmail.com>
To: Gary Thomas <gary@mlbassoc.com>
Cc: Paul Eggleton <paul.eggleton@linux.intel.com>,
	Chris Larson <clarson@kergoth.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Some 'depexp' nits
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
X-List-Received-Date: Fri, 08 Nov 2013 12:37:55 -0000
Content-Type: text/plain; charset=UTF-8

On 8 November 2013 12:28, Gary Thomas <gary@mlbassoc.com> wrote:
> I sent a patch, but I never received it from the list although
> I can find it in the list archives.  This made me think I had
> messed up somehow, so I ended up sending it three times :-(

As it is on the archives it made it to the list...  maybe you
accidently turned off delivery of the list mails, or that list doesn't
send your own messages back to you (I know gmail at least recognises
mails that you sent and doesn't show them in your inbox).


Ross

