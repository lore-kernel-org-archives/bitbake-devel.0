Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id CBD5E60111
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Nov 2016 12:19:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uANCJktT031021; Wed, 23 Nov 2016 12:19:46 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SI-rIqL4csIM; Wed, 23 Nov 2016 12:19:46 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uANCJfbW031017
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 23 Nov 2016 12:19:42 GMT
Message-ID: <1479903581.28508.141.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Brian Avery <avery.brian@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Wed, 23 Nov 2016 12:19:41 +0000
In-Reply-To: <CAKV_0ejdeTDQ6qvujS=8WC_nCCfgvoxVdwva12r_E1k+uRoTtg@mail.gmail.com>
References: <cover.1478749786.git.brian.avery@intel.com>
	<CAKV_0ejdeTDQ6qvujS=8WC_nCCfgvoxVdwva12r_E1k+uRoTtg@mail.gmail.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Cc: brian avery <brian.avery@intel.com>
Subject: Re: [PATCH 0/3] toaster: add master branch back into new project options
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
X-List-Received-Date: Wed, 23 Nov 2016 12:19:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2016-11-22 at 13:19 -0800, Brian Avery wrote:
> ohana.  Did this get left behind or forgotten?  It would be nice for
> toaster to be able to build from master again :),

Perhaps glance at master-next next time. It has been in there a while,
along with the datastore changes which I've been testing a bit more
widely before merging.

Its all in master now.

Cheers,

Richard

