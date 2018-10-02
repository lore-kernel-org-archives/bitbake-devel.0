Return-Path: <olof.johansson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id D8F6971A0C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Oct 2018 18:12:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 95F0718464;
	Tue,  2 Oct 2018 20:12:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id u5l0YsFew3eO; Tue,  2 Oct 2018 20:12:09 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id DCCE7180E5;
	Tue,  2 Oct 2018 20:12:09 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C2151E074;
	Tue,  2 Oct 2018 20:12:09 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70A5C1E072;
	Tue,  2 Oct 2018 20:12:09 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder03.se.axis.com (Postfix) with ESMTP;
	Tue,  2 Oct 2018 20:12:09 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (lnxolofjn.se.axis.com [10.92.17.1])
	by thoth.se.axis.com (Postfix) with ESMTP id 64E89273D;
	Tue,  2 Oct 2018 20:12:09 +0200 (CEST)
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)
	id 55AAF9C0E2; Tue,  2 Oct 2018 20:12:09 +0200 (CEST)
Date: Tue, 2 Oct 2018 20:12:09 +0200
From: Olof Johansson <olof.johansson@axis.com>
To: Mark Hatle <mark.hatle@windriver.com>
Message-ID: <20181002181209.bavoftlvuhklyy5e@axis.com>
Mail-Followup-To: Mark Hatle <mark.hatle@windriver.com>,
	bitbake-devel@lists.openembedded.org
References: <fa53fd11-b621-63ae-a1a6-bf2a4803a796@javox-solutions.com>
	<8d43b616-bc80-ea15-3d44-396a53c74392@windriver.com>
MIME-Version: 1.0
In-Reply-To: <8d43b616-bc80-ea15-3d44-396a53c74392@windriver.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: gitsm fetcher does not work anymore
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
X-List-Received-Date: Tue, 02 Oct 2018 18:12:11 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 18-10-02 12:14 -0500, Mark Hatle wrote:
> (Does the git fetcher support ssh uris?)

Well, not an ssh:// uri, but

  git://example.com/repo.git;protocol=ssh

-- 
olofjn

