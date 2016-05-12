Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 0C4AF601D3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 23:10:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4CNAkFW007224; Fri, 13 May 2016 00:10:46 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id XQ5bk4dGZM3P; Fri, 13 May 2016 00:10:46 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4CNAgGc007221
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 May 2016 00:10:44 +0100
Message-ID: <1463094642.9746.58.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Humberto Ibarra <humberto.ibarra.lopez@intel.com>,
	bitbake-devel@lists.openembedded.org
Date: Fri, 13 May 2016 00:10:42 +0100
In-Reply-To: <1463093720.9746.57.camel@linuxfoundation.org>
References: <1463080671-27074-1-git-send-email-humberto.ibarra.lopez@intel.com>
	<1463093720.9746.57.camel@linuxfoundation.org>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH v3] bitbake/lib/bb/cookerdata.py: Improve response when bitbake-layers can't find layer conf file
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
X-List-Received-Date: Thu, 12 May 2016 23:10:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2016-05-12 at 23:55 +0100, Richard Purdie wrote:
> It would be good to double check as I just tested this with bitbake 
> and bitbake-layers hasn't been ported to python3 yet but I'd imagine 
> its the same.

I just pushed an update to the branch which fixes bitbake-layers under
python3 and confirmed it does show the filename.

Cheers,

Richard


