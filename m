Received: from smtp-relay2.palm.com ([64.28.152.243])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <prvs=427529a58=rich.pixley@palm.com>)
	id 1SD1JO-0005u7-0X for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 00:25:50 +0200
X-IronPort-AV: E=Sophos;i="4.75,333,1330934400"; d="scan'208";a="12561190"
Received: from unknown (HELO ushqusdns4.palm.com) ([148.92.223.164])
	by smtp-relay2.palm.com with ESMTP; 28 Mar 2012 15:15:41 -0700
Received: from fuji-land.noir.com ([10.100.2.7])
	by ushqusdns4.palm.com (8.14.4/8.14.4) with ESMTP id q2SMFf8S001205;
	Wed, 28 Mar 2012 15:15:41 -0700
Message-ID: <4F738D8D.4010408@palm.com>
Date: Wed, 28 Mar 2012 15:15:41 -0700
From: Rich Pixley <rich.pixley@palm.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7;
	rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: chasing mirrors
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 28 Mar 2012 22:25:50 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

How do I determine which mirror was/is being used to download a 
particular component?

I'm expecting some info in a log, or from the output of "bitbake -D", 
but I'm not finding it.  And from a glance at the code I don't see any 
message statements around the mirror iterations although I could easily 
be missing it.

--rich


