Return-Path: <rep.dot.nop@gmail.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id 9A4DE759CF
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Jun 2015 21:50:06 +0000 (UTC)
Received: by wiwd19 with SMTP id d19so87596032wiw.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Jun 2015 14:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=user-agent:in-reply-to:references:mime-version
	:content-transfer-encoding:content-type:subject:from:date:to:cc
	:message-id; bh=YWLptzEDXCc+nRwoq7H27VssIX6j+SI0Nj+w1+wgVdE=;
	b=E1RA1gRzx1y+MDIxYngs63lOVoIwKyg8iLaDHgmB2eeBQ608Q73+zz87ED03+LBVfu
	JxtzfKIf7/G7gokiNvMJBQ5GgcICBlZuKb/K1lqyLqyikJ4hOQnSkbaSOXEQBJCU1Lsz
	zad1a5ucYU32phm0Rl52vLvoiW5IQP21wBD0/4jz2kjOXVfhuqKKhrQMw6/fIYcaGH4f
	3bpSqKd2Xm6cbfdZZHAA7ARjj7KevO13rHNjXnhvQGluYIsK8vwWxOsTbzV3rgYRjXi6
	TzFlFF58Lp54hgEyaxldvGe2XdXGe9nKgzKQ6A9JDXeF+RNhtoe/6NBhSFhfAfS52BrS
	VFAg==
X-Received: by 10.180.37.230 with SMTP id b6mr35431862wik.14.1434405007029;
	Mon, 15 Jun 2015 14:50:07 -0700 (PDT)
Received: from [192.168.100.51] (91-119-107-84.dynamic.xdsl-line.inode.at.
	[91.119.107.84])
	by mx.google.com with ESMTPSA id bh7sm20808245wjb.8.2015.06.15.14.50.05
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 15 Jun 2015 14:50:06 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <41DEA4B02DBDEF40A0F3B6D0DDB123798D203356@ORSMSX101.amr.corp.intel.com>
References: <1429121824-31200-2-git-send-email-Liam.Howlett@WindRiver.com>
	<1431429477.30971.123.camel@linuxfoundation.org>
	<20150512142807.GB15805@yow-lhowlett-d0.wrs.com>
	<2131793.ifvVUYI7Oy@peggleto-mobl.ger.corp.intel.com>
	<557ED558.10502@mlbassoc.com>
	<41DEA4B02DBDEF40A0F3B6D0DDB123798D203356@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Date: Mon, 15 Jun 2015 23:47:29 +0200
To: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>,
	Gary Thomas <gary@mlbassoc.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Message-ID: <1FDE9321-AA20-49D9-A4BE-A4B4514439DB@gmail.com>
Cc: "Howlett, Liam \(Wind River\)" <liam.howlett@windriver.com>,
	Paul Eggleton <paul.eggleton@linux.intel.com>
Subject: Re: [PATCH v3] fetch2: Add	BB_ALLOWED_NETWORKS	support
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
X-List-Received-Date: Mon, 15 Jun 2015 21:50:06 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8

On June 15, 2015 4:03:11 PM GMT+02:00, "Rifenbark, Scott M" <scott.m.rifenbark@intel.com> wrote:
>Hi, 
>
>Here is a first draft of documenting the BB_ALLOWED_NETWORKS variable
>in the BitBake User Manual.  I re-wrote the original text to be active
>voice and applied some different organization of the facts to help the
>flow out.  Regarding Gary's input about BB_NO_NETWORK..... I took a
>half guess at incorporating it.  Please look this new description over
>and let me know of any corrections I need to make. 
>http://www.yoctoproject.org/docs/1.9/bitbake-user-manual/bitbake-user-manual.html#var-BB_ALLOWED_NETWORKS.

Was the v3 fixed / extended to allow for netmasks, btw?
Think
/etc/hosts
foo.example.com 10.0.0.1
bar.example.com 10.0.0.254
baz.example.com ::1

BB_ALLOWED_NETWORKS = 10.0.0.0/24 1.1.1.1/31 ::1/127

Thanks,


