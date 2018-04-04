Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id A726972ED6
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Apr 2018 07:56:30 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w347uGW5022510
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Wed, 4 Apr 2018 08:56:18 +0100
Message-ID: <1522828576.11431.280.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Niko Mauno <niko.mauno@iki.fi>, bitbake-devel@lists.openembedded.org
Date: Wed, 04 Apr 2018 08:56:16 +0100
In-Reply-To: <20180323092821.106187-1-niko.mauno@iki.fi>
References: <20180323092821.106187-1-niko.mauno@iki.fi>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.3 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH] bitbake: fetch2/svn: Add tarsnapshots parameter
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
X-List-Received-Date: Wed, 04 Apr 2018 07:56:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2018-03-23 at 11:28 +0200, Niko Mauno wrote:
> By adding 'tarsnapshots=currentonly' option to svn-specific component
> in
> SRC_URI, associated subversion repository module's existing tarball
> snapshots are removed from DL_DIR, before creating a new one.
> 
> This provides a means to avoid downloads directory becoming congested
> with a subversion repository module's tarball snapshots, which may
> occur
> for example during circumstances where source code residing in a
> subversion repository is subject to long-term development work, and
> recipe used in continuous integration builds has SRCREV set to
> AUTOREV.
> 
> Signed-off-by: Niko Mauno <niko.mauno@iki.fi>

This model does't really work as if multiple things share the downloads
directory there is a race window between the old tarballs being removed
and the new one being created. The downloads and sstate directories are
commonly shared between builds so we need to be mindful of this.

Cheers,

Richard

