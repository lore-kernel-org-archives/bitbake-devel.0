Return-Path: <olof.johansson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id A095C761D3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jul 2015 11:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 69F2E2E4AF;
	Tue, 28 Jul 2015 13:00:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id Hdt5L31CxQeT; Tue, 28 Jul 2015 13:00:58 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 07E352E4AD;
	Tue, 28 Jul 2015 13:00:57 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id AFC8A10FB;
	Tue, 28 Jul 2015 13:00:57 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 99F68B8B;
	Tue, 28 Jul 2015 13:00:57 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 9698E34005;
	Tue, 28 Jul 2015 13:00:57 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0; Tue, 28 Jul 2015
	13:00:57 +0200
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 4AA549C68B; 
	Tue, 28 Jul 2015 13:00:57 +0200 (CEST)
From: Olof Johansson <olof.johansson@axis.com>
To: Juro Bystricky <juro.bystricky@intel.com>,
	<bitbake-devel@lists.openembedded.org>
In-Reply-To: <1437849163-1577-1-git-send-email-juro.bystricky@intel.com>
References: <1437849163-1577-1-git-send-email-juro.bystricky@intel.com>
Date: Tue, 28 Jul 2015 13:00:57 +0200
Message-ID: <1438081047-sup-2928@axis.com>
User-Agent: Sup/0.20.0
MIME-Version: 1.0
Subject: Re: [PATCH] wget.py: support for semi-colons in URL
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
X-List-Received-Date: Tue, 28 Jul 2015 11:01:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Excerpts from Juro Bystricky's message of 2015-07-25 20:32:43 +0200:
> Some URLs contain semi-colons. For example, some GIT repositories
> support downloading snapshots using URL such as:
> 
> "http://abc123.com/git/?p=gcc/gcc.git;a=snapshot;h=a5dd47"
> 
> Currently there is no way to construct SRC_URI with such URLs.
> Bitbake uses semi-colons in SRC_URI as delimiters for various parameters.

W3C _recommends_ [1] that HTTP URL consumers treat ; in query strings as
an &:

> We recommend that HTTP server implementors, and in particular, CGI
> implementors support the use of ";" in place of "&" to save authors
> the trouble of escaping "&" characters in this manner.

This means that

  http://abc123.com/git/?p=gcc/gcc.git;a=snapshot;h=a5dd47

and

  http://abc123.com/git/?p=gcc/gcc.git&a=snapshot&h=a5dd47

should be equivalent. I don't know how well spread this support is, or
if it works in your case, but it's a workaround if it does at least.

1: http://www.w3.org/TR/1999/REC-html401-19991224/appendix/notes.html#h-B.2.2

-- 
olof johansson

