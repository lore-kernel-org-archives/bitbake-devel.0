Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id BFB9D60119
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Feb 2016 17:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1BHCZqq011091; Thu, 11 Feb 2016 17:12:36 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id OU4sed0YODKr; Thu, 11 Feb 2016 17:12:35 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1BHCUfW011088
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 11 Feb 2016 17:12:31 GMT
Message-ID: <1455210750.16142.262.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Brian Avery <avery.brian@gmail.com>, Elliot Smith <elliot.smith@intel.com>
Date: Thu, 11 Feb 2016 17:12:30 +0000
In-Reply-To: <CAKV_0ei6-uSkVqLf3pc4T8f5y-cZLiBDD5jv61AUHc_Y5kveRA@mail.gmail.com>
References: <1449828119-23489-1-git-send-email-elliot.smith@intel.com>
	<CAKV_0ei6-uSkVqLf3pc4T8f5y-cZLiBDD5jv61AUHc_Y5kveRA@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: Mihail Stanciu <stanciux.mihail@intel.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] toaster: tests Remove symlinks from toasteruitest folder
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
X-List-Received-Date: Thu, 11 Feb 2016 17:12:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2016-02-09 at 12:33 -0800, Brian Avery wrote:
> bump.
> This seems to have neither made it in to master nor gotten any
> comments...

It made it to bitbake master but got lost for poky. I've fixed that.

Cheers,

Richard

