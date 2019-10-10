Return-Path: <mark.hatle@kernel.crashing.org>
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
	by mail.openembedded.org (Postfix) with ESMTP id D75A26011A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Oct 2019 23:53:57 +0000 (UTC)
Received: from Marks-MacBook-Pro.local ([76.164.61.198]) (authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id x9ANrrCO004570
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NO); Thu, 10 Oct 2019 18:53:54 -0500
To: Nicolas Dechesne <nicolas.dechesne@linaro.org>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20191008184512.20130-1-anibal.limon@linaro.org>
	<47c79ccca81ec9c237357f4a91973d2b6cee77e1.camel@linuxfoundation.org>
	<CAP71WjyAPhw6f+9ZW0NMdzhV-cwWcNc3SLCO74Sv+noXnyX7tA@mail.gmail.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <1c61b38a-d1a5-cacc-960c-012cb4dd3f88@kernel.crashing.org>
Date: Thu, 10 Oct 2019 18:53:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
	Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAP71WjyAPhw6f+9ZW0NMdzhV-cwWcNc3SLCO74Sv+noXnyX7tA@mail.gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [RFC][WIP][PATCHv1] lib/bb/checksum.py: Speed-up checksum gen when directory is git
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
X-List-Received-Date: Thu, 10 Oct 2019 23:53:58 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 10/9/19 4:02 AM, Nicolas Dechesne wrote:
> On Wed, Oct 9, 2019 at 1:15 AM <richard.purdie@linuxfoundation.org> wrote:
>>
>> On Tue, 2019-10-08 at 13:45 -0500, Aníbal Limón wrote:
>>> In some cases people/organizations are using a SRC_URI with
>>> file:///PATH_TO_DIR that contains a git repository for different
>>> reasons, it is useful when want to do an internal build without
>>> clone sources from outside.
>>>
>>> This could consume a lot of CPU time because the current taskhash
>>> generation mechanism didn't identify that the folder is a VCS
>>> (git, svn, cvs) and makes the cksum for every file including the
>>> .git repository in this case.
>>>
>>> There are different ways to improve the situation,
>>>
>>> * Add protocol=gitscm in file:// SRC_URI but the taskhash is
>>>   calculated before the fetcher identifies the protocol, will require
>>>   some changes in bitbake codebase.
>>> * This patch: When directory is a git repository (contains .git)
>>>   use HEAD rev + git diff to calculate checksum instead of do it
>>>   in every file, that is hackish because make some assumptions about
>>>   .git directory contents.
>>> * Variant of this patch: Make a list of VCS directories (.git, .svn,
>>>   .cvs) and take out for cksum calculations, same as before making
>>>   assumptions about the . folders content.
>>
>> This is an interesting one.
> 
> Are you referring to the last bullet here? I suspect it's the second one.
> 
> Also to give a bit more background to everyone, as it might not be
> obvious. I've seen the same pattern used several times , especially in
> large/corporate deployment of OE/YP. the whole build workspace is
> built as:
> 
> |- sources
> |---- kernel
> |---- component_A
> |---- component_B
> |- layers
> |---- poky
> |---- meta-mycompany
> |-------- recipes for kernel, component_A, ...
> 
> The whole workspace is managed with a repo manifest, and the recipes
> are written to use source code from the 'sources' local folder.

This exact situation is why (when I was at WR) we patched git-repo to allow for
bare repository checkouts.. There is no reason for source/* to be checked out,
but it does need a local clone for performance.

Once you have a local clone then you can use the mirroring to point to it and
everything works properly using git://....;protocol=file

> I am not trying to argue whether this is a good practice or not ;-)
> but from the perspectives of the folks I've talked to , there are a
> couple of critical advantages of doing something like that:

The problem with google's restrictive patch submission requirements is I was
never able to push the changes back to google to enable these bare
repositories.. but the patches have been published and are regularly updated at:

https://github.com/WindRiver-OpenSourceLabs/git-repo

Look in the master-next / master-wr-next branches for the rebased versions.

> * it looks like Android development workflow ;-)
> * it relates to the company license/legal process and review. e.g. all
> the software that gets out of the company is managed by a single repo
> manifest xml file
> * it solves "nicely" the problem of being able to iteratively develop
> using bitbake natively. e.g. "bibtake myimage" always work, and uses
> local changes from 'sources'

Yes, all of that can be accomplished with a bare checkout...  but even if you
don't do a bare checkout, you can still do this with bitbake the way it is.

Instead of pointing to sources/kernel you would point to 'sources/kernel/.git'..

PREMIRRORS_append := "\
     git://.*/.* file://${LAYERDIR}/downloads/ \n \
     git://.*/.* git://${LAYERDIR}/../../git/BASENAME;protocol=file \n \
     git://.*/.* git://${LAYERDIR}/../../git/MIRRORNAME;protocol=file \n \
"

For the bare version the above works...  (The file one is for a 'download
tarball'...)

Otherwise, '/.git' after the 'NAME' to do the checked out version.  (I've not
tried this recently but it used to work...  but dramatically increases the
length of time required for a download.)

> So overall, i am being convinced that this is a valid use case for OE
> end users. I don't think we can use the git:// fetcher as we need the
> snapshot of the current 'sources' (with local changes), and using the

I think we need to be precise on what you mean by local changes.  Local as in
not yet committed?  Or local as in on the local disk.  The later you can
definitely use the mirroring.. the former you need to use other approaches to
satisfy (externalsrc... but then you run into the any file changes and it will
rebuild.   If anything, I'd say maybe externalsrc needs to be enhanced?)

> file:// fetcher has important performance impacts:
> * checksum for 'each' file (which can be large, especially for kernel)
> * un-expected rebuild when running repo sync, if any new git objects
> are put in .git (even when no changes are made to the local worktree
> of the git project).

This is why using git://... is needed to tell the system to use the git
formatting and ignore just new files.

--Mark

>>
>> File checksums are added to the hashes "late" so that we don't have to
>> reparse entire recipes when files change. We do need a mechanism to
>> know when we need to reparse the checksum. I think this means you can
>> skip the checksum calculation for each file but you do still end up
>> having to stat all files in the tree separately for bitbake's tracking
>> and for git. We also have to notice when new files are added.
>>
>> As such I'm not convinced this patch will work correctly (e.g. would it
>> notice if I copy in a new file to the directory untracked by git).
> 
> At least I confirm that with the file:// fetcher everything works
> fine, when modifying files. I don't think I have tried adding new
> files. But I will try that.
> 
> Are you trying to say that to fix this properly we might need another
> Fetcher , something in between file:// and git://, e.g. localgit://?
> Would that make this problem easier to solve?
> 
>>
>> A first step may be to add some further tests to bitbake-selftest to
>> better cover this area...
>>
>> Cheers,
>>
>> Richard
>>
>>
>>
>>
>>

