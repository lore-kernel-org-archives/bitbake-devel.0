Return-Path: <olof.johansson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id C4D647DE81
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Jun 2019 17:39:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 2397818521;
	Tue,  4 Jun 2019 19:39:01 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 9tR_mw7dk5dV; Tue,  4 Jun 2019 19:39:00 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id 3DC851848E;
	Tue,  4 Jun 2019 19:39:00 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21BDD1A072;
	Tue,  4 Jun 2019 19:39:00 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 169401A06D;
	Tue,  4 Jun 2019 19:39:00 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder02.se.axis.com (Postfix) with ESMTP;
	Tue,  4 Jun 2019 19:39:00 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (lnxolofjn.se.axis.com [10.92.17.1])
	by thoth.se.axis.com (Postfix) with ESMTP id 0A7E33123;
	Tue,  4 Jun 2019 19:39:00 +0200 (CEST)
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)
	id 008CF9C0BC; Tue,  4 Jun 2019 19:38:59 +0200 (CEST)
Date: Tue, 4 Jun 2019 19:38:59 +0200
From: Olof Johansson <olof.johansson@axis.com>
To: Leif Middelschulte <leif.middelschulte@klsmartin.com>
Message-ID: <20190604173859.napxayq2tbfvgcx2@axis.com>
Mail-Followup-To: Leif Middelschulte <leif.middelschulte@klsmartin.com>,
	bitbake-devel@lists.openembedded.org
References: <20190604160137.5636-1-leif.middelschulte@klsmartin.com>
MIME-Version: 1.0
In-Reply-To: <20190604160137.5636-1-leif.middelschulte@klsmartin.com>
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
X-List-Received-Date: Tue, 04 Jun 2019 17:39:02 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 19-06-04 18:01 +0200, Leif Middelschulte wrote:
> This patch fixes initial clones of git repositories authenticated
> via basic http authentication. This became apparent when code was
> reused to clone submodules too.
> 
> The method is the recommended way of cloning source code by CI
> runners. This patch fixes the currently broken behvior.

Hi,

Recommended by whom specifically? Encoding passwords in URIs was
deprecated RFC 3986 for security reasons. Some tools may not be
aware of security sensitive information contained in URIs.

RFC 3986:
> Applications should not render as clear text any data after the
> first colon (":") character found within a userinfo
> subcomponent ...

Having passwords and security sensitive info in the bitbake
metadata also seems a bit weird to me, but bb.fetch2.decodeurl()
does support extracting it. I thought the git fetcher didn't
support auth details (other than user) via the URI by design, but
this is just my assumption.

The gitcredentials manpage recommends using the global
configuration with [credential.<uri-pattern>] blocks to specify
this instead.

https://git-scm.com/docs/gitcredentials

-- 
olofjn

