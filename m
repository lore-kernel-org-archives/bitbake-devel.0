Return-Path: <olof.johansson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 8637379CB1
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Dec 2018 14:32:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id D2D26182DA;
	Fri,  7 Dec 2018 15:32:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id rOlI3U_3Rmzo; Fri,  7 Dec 2018 15:32:40 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id 6C90B18485;
	Fri,  7 Dec 2018 15:32:40 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD1CB1E081;
	Fri,  7 Dec 2018 15:32:39 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B19CB1E07A;
	Fri,  7 Dec 2018 15:32:39 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder03.se.axis.com (Postfix) with ESMTP;
	Fri,  7 Dec 2018 15:32:39 +0100 (CET)
Received: from lnxolofjn.se.axis.com (lnxolofjn.se.axis.com [10.92.17.1])
	by thoth.se.axis.com (Postfix) with ESMTP id A5B9D2B91;
	Fri,  7 Dec 2018 15:32:39 +0100 (CET)
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)
	id 98AF39C4F2; Fri,  7 Dec 2018 15:32:39 +0100 (CET)
Date: Fri, 7 Dec 2018 15:32:39 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20181207143239.k6dtjdyt7nysf4cw@axis.com>
Mail-Followup-To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
References: <20181207130922.18311-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <20181207130922.18311-1-richard.purdie@linuxfoundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2/wget: Fix typo in exception name
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
X-List-Received-Date: Fri, 07 Dec 2018 14:32:41 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 18-12-07 13:09 +0000, Richard Purdie wrote:
> This could clearly never have worked but as its in an error path, it doesn't
> get tested/used much.

For the record, could clearly never have worked *since* the python3 migration.

  commit 0f2c59367a649de5f57acdccfb4f1fdba9cde730
  Author: Richard Purdie <richard.purdie@linuxfoundation.org>
  Date:   Thu May 12 08:30:35 2016 +0100

      bitbake: bitbake: Convert to python 3

-- 
olofjn

