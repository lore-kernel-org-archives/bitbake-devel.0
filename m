Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 0B29273223;
	Wed, 27 May 2015 22:43:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4RMhZAP009876; Wed, 27 May 2015 23:43:35 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0bEap39AVdVB; Wed, 27 May 2015 23:43:35 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4RMhMOA009850
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 27 May 2015 23:43:33 +0100
Message-ID: <1432766602.404.90.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 27 May 2015 23:43:22 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: openembedded-core <openembedded-core@lists.openembedded.org>
Subject: RFC: update_data removal
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
X-List-Received-Date: Wed, 27 May 2015 22:43:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Removing the need for finalization or update_data is something we've
idly thought about for a long time. Basically, the whole idea of a
specific finalization phase to the data store causes a lof of issues and
horrible corner cases. For example, should bitbake call update_data,
then expandKeys, or the other way around? Or should we keep calling
update_data until nothing changes?

Through careful thought of some operations and working around the corner
case problems, we've avoided most of the issues however there are some
things we keep observing:

* We keep needing "expanded" data stores in different parts of the 
  system alongside their unexpanded versions
* Few people understand why/when exactly they should call update_data()
* Its near impossible to set PREFERRED_PROVIDERS of recipes which are 
  dynamically named (gcc-cross-${TARGET_ARCH}) along with overrides. 
  This is something meta-darwin/mingw/baremetal could really use.

The alternative is a datastore which dynamically adjusts when anything
changes so that the work is done at getVar time rather than precaching
things at update_data time.

I've been experimenting with this and I do have a branch which basically
works:

http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=rpurdie/noupdatedata5

This is based on a set of patches which I've already posted and added to
master-next and there are 10 patches on top of those specific to the
update_data changes. The details of each step in the changes I worked
through are recorded there.

Obviously such a major change to a key piece of code needs careful
testing. I made some before/after analysis of these changes by diffing
the signatures before and after this change for a core-image-sato:

rm tmp-test/ -rf; git stash; git checkout cmop; bitbake core-image-sato -S none; git checkout master; git stash apply; bitbake core-image-sato -S none; bitbake-sigwalker > rp5

(sigwalker goes through tmp/stamps and finds any case where there are two stamps and diffs them)

$ grep "value changed" rp5  | grep PROVIDES.*native -v | grep DEPENDS.*BASEDEPENDS -v | grep PACKAGESPLITFUNCS -v
   Variable pkg_postrm value changed from 'None' to ''
   Variable KERNEL_MODULE_AUTOLOAD value changed from 'None' to ''

So basically there are 3 different cases. The ones printed in full above
where None and '' have been mixed up. I'm classing that as an
improvement. The PACKAGESPLITFUNCS consists of:

Variable PACKAGESPLITFUNCS value changed from 'populate_packages_updatercd                  package_do_split_locales                 populate_packages' to 'populate_packages_updatercd package_do_split_locales populate_packages'

which is just whitespace changes and doesn't concern me. The other
changes are from a change in behaviour of the class extension code.
Previously, when the class (e.g. native.bbclass) changed the values, it
didn't process any append/prepends. The new code does also expand and
update the append/prepends. Having looked carefully at the result, there
is a lot of noise in the difference where ${PN} changes to its expanded
version but I don't believe there is a functionality change or issue.
This results in DEPENDS and PROVIDES changing in the native case. This
also results in:

$ grep removed rp5 | sort | uniq
   Dependency on Variable autotools_dep_prepend was removed
   Dependency on Variable BASEDEPENDS was removed
   Dependency on Variable base_dep_prepend was removed
   Dependency on Variable DEPENDS_GETTEXT was removed
   Dependency on Variable gettext_dependencies was removed
   Dependency on Variable process_file was removed
   Dependency on Variable TEXDEP was removed
   Dependency on Variable USERADDDEPENDS was removed

There were no dependencies added.

Performance is another key question. Initially this work had some pretty
poor performance which isn't surprising give how much we've tweaked the
current code. With the improvements in the branch, we're now at:

Before:

real	0m7.659s
user	2m6.129s
sys	0m5.844s

After:

real	0m7.990s
user	2m10.748s
sys	0m6.116s


So the new code is slower, but not by much. Initially this was more like
a 2m44 user time. This is now in the region where I think we should
seriously consider the code.

What is missing from the branch as yet is removal of the "expanded" data
stores from use within bitbake and starting to remove the update_data
calls (which are now just empty calls).

So any thoughts/questions/comments/suggestions on this?

I'll obviously continue to ramp up the testing on this. Working on this
has exposed a few interesting bugs in the existing metadata!

Cheers,

Richard


