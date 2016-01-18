Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id EEFEF60588
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jan 2016 22:09:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0IM9ViY010890; Mon, 18 Jan 2016 22:09:31 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mxKrIxyuYtl3; Mon, 18 Jan 2016 22:09:31 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0IM9Rae010886
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 18 Jan 2016 22:09:28 GMT
Message-ID: <1453154967.27999.93.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ed Bartosh <ed.bartosh@linux.intel.com>,
	bitbake-devel@lists.openembedded.org
Date: Mon, 18 Jan 2016 22:09:27 +0000
In-Reply-To: <cover.1453124453.git.ed.bartosh@linux.intel.com>
References: <cover.1453124453.git.ed.bartosh@linux.intel.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: "toaster@yoctoproject.org" <toaster@yoctoproject.org>
Subject: Re: [PATCH 0/3] Fix SDK downloads forbuilds
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
X-List-Received-Date: Mon, 18 Jan 2016 22:09:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2016-01-18 at 15:45 +0200, Ed Bartosh wrote:
> Elliot Smith (3):
>   toaster: toasterui: listen for bb.event.MetadataEvent
>   toaster: toasterui: log OSErrorException metadata events
>   toaster: toastergui: make artifact download more robust

Its a small detail but when sending patches, "toasterui:" is fine in
the shortlog, we don't need "toaster: toasterui:". The idea is to
highlight which bit of the system is being changed and "toasterui"
conveys that fine.

[cc'd to the toaster list so everyone sees this]

No need to resend these, I just tweaked the lines.

Cheers,

Richard

