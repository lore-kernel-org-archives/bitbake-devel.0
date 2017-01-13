Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E21AE605C2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Jan 2017 10:54:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0DAsmrP002750; Fri, 13 Jan 2017 10:54:48 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id A9qzhs3QXXBa; Fri, 13 Jan 2017 10:54:48 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0DAsgx7002742
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Jan 2017 10:54:43 GMT
Message-ID: <1484304882.4367.252.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Juro Bystricky <juro.bystricky@intel.com>,
	bitbake-devel@lists.openembedded.org
Date: Fri, 13 Jan 2017 10:54:42 +0000
In-Reply-To: <1484264431-28529-1-git-send-email-juro.bystricky@intel.com>
References: <1484264431-28529-1-git-send-email-juro.bystricky@intel.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Cc: jurobystricky@hotmail.com
Subject: Re: [PATCH] cookerdata.py: check for existence of configuration files
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
X-List-Received-Date: Fri, 13 Jan 2017 10:54:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2017-01-12 at 15:40 -0800, Juro Bystricky wrote:
> Presently there is no check to verify the existence of configuration
> files as listed in BBMULTICONFIG. For example, BBMULTICONFIG =
> "foobar" in local.conf
> does not trigger an error when there is no
> conf/multiconfig/foobar.conf.
> The missing file is silently ignored.
> 
> This patch verifies the existence of config files and errors-out with
> the message:
> 
> ERROR: BBMULTICONFIG="foobar" but the configuration file
> './conf/multiconfig/foobar.conf' does not exist!
> 
> when the file does not exist.
> 
> [YOCTO#10917]

Sorry but we can't do this. One reason for some of the recent changes
was to move the handling of this to the metadata and out of bitbake.
We've therefore now got:

include conf/multiconfig/${BB_CURRENT_MC}.conf

in bitbake.conf and the system looks for the file that way. The user is
free to add other files in other paths and bitbake doesn't know/care
about the directory layout.

If we really want to make this error, we'd need to add an empty
conf/multiconfig/default.conf and then change this to a require instead
of an include. Bitbake's standard error messages would then kick in.

Cheers,

Richard

