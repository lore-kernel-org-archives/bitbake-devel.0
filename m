Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 78F5E65DA3;
	Thu, 14 May 2015 09:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4E9l1rQ016251; Thu, 14 May 2015 10:47:01 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3yoebtPCZhjX; Thu, 14 May 2015 10:47:01 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4E9knZ3016243
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 14 May 2015 10:47:00 +0100
Message-ID: <1431596809.30971.197.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jate Sujjavanich <jatedev@gmail.com>
Date: Thu, 14 May 2015 10:46:49 +0100
In-Reply-To: <CAPphmgY46h8ajbqL66rynRf2-u28a0duxPFV3MqPjb_iB_RvaA@mail.gmail.com>
References: <CAPphmgY46h8ajbqL66rynRf2-u28a0duxPFV3MqPjb_iB_RvaA@mail.gmail.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: [PATCH v2][2/2] image.bbclass/rootfs.py: use PREFERRED_RPROVIDER to select package
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
X-List-Received-Date: Thu, 14 May 2015 09:47:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2015-05-13 at 18:47 -0400, Jate Sujjavanich wrote:
> +python rootfs_process_preferred_rproviders() {
> +    inst_pkgs = d.getVar("PACKAGE_INSTALL", True).split()
> +    pref_pkgs = list()
> +    for pkg in inst_pkgs:
> +        prefervar = d.getVar("PREFERRED_RPROVIDER_%s" % pkg, True)
> +        if prefervar:
> +            inst_pkgs.remove(pkg)
> +            pref_pkgs.append(prefervar)
> +            bb.note("Selecting %s to provide %s due to
> PREFERRED_RPROVIDER" % (prefervar, pkg))
> +    inst_pkgs.extend(pref_pkgs)
> +    d.setVar("PACKAGE_INSTALL", ' '.join(inst_pkgs))
> +}
> +do_rootfs[prefuncs] += "rootfs_process_preferred_rproviders"
> +
>  # We have to delay the runtime_mapping_rename until just before
> rootfs runs
>  # otherwise, the multilib renaming could step in and squash any
> fixups that
>  # may have occurred.

This kind of approach to the problem basically doesn't scale. Yes, it
will rewrite things in PACKAGE_INSTALL however if package A depends on
package B using one of these names, the mechanism will simply not work.
This will in turn generate a whole new world of bug reports with no way
to really fix the problems.

This is why we have other mechanisms for handling the runtime provider
names, usually through parametrisation with variables so that when you
rewrite an entry, *all* entries get rewritten and what the package
manager sees is consistent.

I would also note that in the past, bitbake once did have
PREFERRED_RPROVIDER support. We dropped it as it caused problems. I
suspect I would have written up some rationale for that when we did it
which would be in the list archives.

Cheers,

Richard



