Return-Path: <olof.johansson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 9027F7DE74
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Jun 2019 17:50:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 0617418535;
	Tue,  4 Jun 2019 19:50:09 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id Mu454x2OJ-cQ; Tue,  4 Jun 2019 19:50:08 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id 581A018403;
	Tue,  4 Jun 2019 19:50:08 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CFE61E07F;
	Tue,  4 Jun 2019 19:50:08 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 314AB1E07E;
	Tue,  4 Jun 2019 19:50:08 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder03.se.axis.com (Postfix) with ESMTP;
	Tue,  4 Jun 2019 19:50:08 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (lnxolofjn.se.axis.com [10.92.17.1])
	by thoth.se.axis.com (Postfix) with ESMTP id 24FE6293C;
	Tue,  4 Jun 2019 19:50:08 +0200 (CEST)
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)
	id DD1079C0BC; Tue,  4 Jun 2019 19:50:07 +0200 (CEST)
Date: Tue, 4 Jun 2019 19:50:07 +0200
From: Olof Johansson <olof.johansson@axis.com>
To: Leif Middelschulte <leif.middelschulte@klsmartin.com>
Message-ID: <20190604175006.uigapx26oi6zhjmr@axis.com>
Mail-Followup-To: Leif Middelschulte <leif.middelschulte@klsmartin.com>,
	bitbake-devel@lists.openembedded.org
References: <20190604160137.5636-1-leif.middelschulte@klsmartin.com>
	<20190604173859.napxayq2tbfvgcx2@axis.com>
MIME-Version: 1.0
In-Reply-To: <20190604173859.napxayq2tbfvgcx2@axis.com>
User-Agent: NeoMutt/20180716
X-TM-AS-GCONF: 00
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/1] bitbake: fetch2/git: fix initial http authed clone
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
X-List-Received-Date: Tue, 04 Jun 2019 17:50:08 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 19-06-04 19:38 +0200, Olof Johansson wrote:
> The gitcredentials manpage recommends using the global
> configuration with [credential.<uri-pattern>] blocks to specify
> this instead.

... Sorry, this was an incomplete description based on a cursory
reading, but it does seem to outline several available solutions
to your problem, including storing unencrypted on disk to
integrating with system password managers...

> https://git-scm.com/docs/gitcredentials

(SSH transport with key based authentication is also nice to deal
with, if possible. The authenticated git hosts I know of provide
SSH transport, but I suppose not all.)

-- 
olofjn

