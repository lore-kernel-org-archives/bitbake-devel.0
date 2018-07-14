Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 94C3E787E9
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 14 Jul 2018 08:50:25 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w6E8oM6h010807
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Sat, 14 Jul 2018 09:50:25 +0100
Message-ID: <4b1ff3b9741cc1b7d19bdfca38eb26d8f1c2b6c2.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: developer_agl@xtev.cn, bitbake-devel@lists.openembedded.org
Date: Sat, 14 Jul 2018 09:50:22 +0100
In-Reply-To: <5b472a90.1c69fb81.97ae4.ba79SMTPIN_ADDED_BROKEN@mx.google.com>
References: <5b472a90.1c69fb81.97ae4.ba79SMTPIN_ADDED_BROKEN@mx.google.com>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.4 at dan
X-Virus-Status: Clean
Subject: Re: About bitbake tasks
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
X-List-Received-Date: Sat, 14 Jul 2018 08:50:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2018-07-12 at 18:09 +0800, developer_agl@xtev.cn wrote:
> Hi,
>  
> I’m new to bitbake. And I have some questions about bitbake tasks
> mechanism and inherit mechanism. If a xxx.bb recipe content like this
> :
>  
> ##start
> DESCRIPTION = ”xxxxxxxxx”
>  
> XXX_XXXX = “${XXXXXXXX}”
>  
> require some_guys
> ##end
>  
> And Bitbake User Manual said that ‘The minimally required class for
> BitBake is the classes/base.bbclass file. The base class is
> implicitly inherited by every recipe.’ So which .bbclass should be
> parsed first, some_guys.bbclass or base.bbclass? I’m really confused
> about that.

base.bbclass is always included first.

Cheers,

Richard

