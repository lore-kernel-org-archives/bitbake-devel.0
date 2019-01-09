Return-Path: <olof.johansson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 035CA7BF82
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jan 2019 01:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 82C4318488;
	Wed,  9 Jan 2019 02:18:28 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id eci-gu11wsPf; Wed,  9 Jan 2019 02:18:28 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id 9F85818487;
	Wed,  9 Jan 2019 02:18:27 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BE761E079;
	Wed,  9 Jan 2019 02:18:27 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 704E21E074;
	Wed,  9 Jan 2019 02:18:27 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder03.se.axis.com (Postfix) with ESMTP;
	Wed,  9 Jan 2019 02:18:27 +0100 (CET)
Received: from lnxolofjn.se.axis.com (lnxolofjn.se.axis.com [10.92.17.1])
	by thoth.se.axis.com (Postfix) with ESMTP id 63D722EB2;
	Wed,  9 Jan 2019 02:18:27 +0100 (CET)
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)
	id 5168D9C4F2; Wed,  9 Jan 2019 02:18:27 +0100 (CET)
Date: Wed, 9 Jan 2019 02:18:27 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: Mark Hatle <mark.hatle@windriver.com>
Message-ID: <20190109011827.4crsftenh2c5pfst@axis.com>
Mail-Followup-To: Mark Hatle <mark.hatle@windriver.com>,
	bitbake-devel@lists.openembedded.org
References: <20190108233847.81353-1-mark.hatle@windriver.com>
	<20190108233847.81353-3-mark.hatle@windriver.com>
MIME-Version: 1.0
In-Reply-To: <20190108233847.81353-3-mark.hatle@windriver.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/3] gitsm.py: Add support for alternative URL formats from submodule files
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
X-List-Received-Date: Wed, 09 Jan 2019 01:18:29 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 19-01-08 18:38 -0500, Mark Hatle wrote:
> Note, in SSH format we simply replace the ':' with a '/' when constructing
> the URL.  However, if the original path was ":/...", we don't want '//' so
> we deal with this corner case as well.
...
> +  if ":/" in uris[module]:
> +      url = "gitsm://" + uris[module].replace(':/', '/', 1)
> +  else:
> +      url = "gitsm://" + uris[module].replace(':', '/', 1)

Without a / prefix in the original ssh path, the path becomes
relative to whatever the ssh server wants, usually the user's
$HOME. I.e., they do not refer to the same path on the remote
system.

  alice@example.com:/foo.git -> ssh://alice@example.com/foo.git
  alice@example.com:foo.git -> ssh://alice@example.com/home/alice/foo.git (or something else!)

The path in an ssh:// uri is absolute, so the relative case must
be handled differently. But it's easy, git supports ~ expansion,
like:

  alice@example.com:foo.git -> ssh://alice@example.com/~/foo.git

-- 
olofjn

