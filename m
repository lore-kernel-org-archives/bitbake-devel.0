Received: from mail-ie0-f181.google.com ([209.85.223.181])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jon.szymaniak@gmail.com>) id 1TgPNu-0002d3-NG
	for bitbake-devel@lists.openembedded.org;
	Thu, 06 Dec 2012 01:32:17 +0100
Received: by mail-ie0-f181.google.com with SMTP id 16so9234625iea.40
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 05 Dec 2012 16:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to:content-type;
	bh=ZC3On89W22OGAtnpfBXulp2ZPbNvyfmO1LbHL428I+Y=;
	b=SFuHFPARCadfkUPIX7zym3pM/grtzdkKrcvbl91W4CGoVfa3Of/KpFHTJHgZIhh5eM
	YdIXVXAYhOJJZ4VLBedMp4KRFWYwv1d1PBzqkVLdFitK6O+6hw2DhqGP4w18XpnlcFcQ
	JtBV1TNa04VxuIO/3YRukBi3SpgwDmTANu0AbcGBric7MFtfKkF6FU9yxdCL6iRlrV1z
	fexxAWlMgeXTOa9jGzruEfP5QTXtecqB5QvPzgUoO6OHvJad2b5oDV7O3OL/lFINuaYo
	xCJ3//Nt8gtLYbu9jZwRPJUiN/kehJEc/mepwMksApG1tmHSq/2m4U39NzROhztAlklY
	90CA==
Received: by 10.50.173.106 with SMTP id bj10mr4107962igc.13.1354753069469;
	Wed, 05 Dec 2012 16:17:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.167.165 with HTTP; Wed, 5 Dec 2012 16:17:29 -0800 (PST)
From: Jon Szymaniak <jon.szymaniak@gmail.com>
Date: Wed, 5 Dec 2012 19:17:29 -0500
Message-ID: <CANge7vVgnJTskixvCtbWThgq8uqrS9fag8DcHL7HLb732ckDNg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Sat, 08 Dec 2012 09:56:26 +0100
Subject: hg fetcher failures for SRCREV set to a tag
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 06 Dec 2012 00:32:17 -0000
Content-Type: text/plain; charset=ISO-8859-1

tl;dr: Doesn't the "update" in lines 142-147 of hg.py cause issues when
SRCREV is a tag?


Hi all,

I didn't have any luck with this post on the Yocto mailing list. Since it seems
more like a bitbake issue (I'm very hesitant to cry "bug" at this point),
I hope I'm in the right place.

I've been running into "Fetcher failures" for my recipes using
mercurial recently, which report that I'm asking for an unknown revision,
despite it being valid. A trimmed log is at the end of this post.

After looking at hg.py, it seems the issue is that the
'hg update -r MY_TAG' that follows the 'hg clone -r MY_TAG ...' is doomed to
fail because that tag isn't visible until the next rev, where the action of
tagging it is committed.

For example, if I clone v1.1.0, I won't see that tag because the tag is added
to .hgtags in commit 41:58b..

      tip                             41:58b8f368be68
      v1.1.0                        40:a925b596c163
      v1.0.4                        39:6bf84da2571e

Therefore once I've cloned with "-r v1.1.0", I can't do an update
specifying tag v1.1.0.

Does this sound right, or am I way off here?

I'm not sure if using a tag rather than the revision number is unorthodox or
abnormal for bb's, so below's my use case, for a my-app_0.1.2.bb

require my-app.inc
PR = "${INC_PR}.0"
SRCREV = "v${PV}"

Therefore to bring in a new version, I can simply copy this file to a
my-app_1.1.0.bb, and adjust PR back to 0 if needed.

We have a policy not to move version tags, so tag-->revision should be 1:1. Is
what I'm seeing a non-issue simply because one shouldn't use tags in SRCREV?


Thank you,
Jon


Snipped Yocto/Poky log:
---------------------------
DEBUG: Fetch: checking for module directory
'/export/home/jon/projects/yocto/poky/build/test/downloads/hg/host/some_dir/my_package'
NOTE: Fetch hg://hg@host/some_dir;module=my_package;protocol=ssh
DEBUG: Running /usr/bin/env hg clone -r v1.1.0
ssh://hg@host/some_dir/my_package my_package
DEBUG: Fetcher accessed the network with the command /usr/bin/env hg
clone -r v1.1.0 ssh://hg@host/some_dir/my_package my_package
DEBUG: Running export HOME="/export/home/jon"; export
SSH_AGENT_PID="1234"; export SSH_AUTH_SOCK="<snipped>"; export
GIT_CONFIG="<snipped>/gitconfig"; export PATH="<snipped>";
/usr/bin/env hg clone -r v1.1.0 ssh://hg@host/some_dir/my_package
my_package
DEBUG: Running /usr/bin/env hg update -C -r v1.1.0
DEBUG: Running export HOME="/export/home/jon"; export
SSH_AGENT_PID="1234"; export SSH_AUTH_SOCK="<snipped>"; export
GIT_CONFIG="<snipped>/gitconfig"; export PATH="<snipped>";
/usr/bin/env hg update -C -r v1.1.0
WARNING: Failed to fetch URL
hg://hg@host/some_dir;module=my_package;protocol=ssh, attempting
MIRRORS if available
DEBUG: Fetcher failure: Fetch command failed with exit code 255, output:
  abort: unknown revision 'v1.1.0'!

DEBUG: Python function base_do_fetch finished
DEBUG: Python function do_fetch finished
ERROR: Function failed: Fetcher failure for URL:
'hg://hg@host/some_dir;module=my_package;protocol=ssh'. Unable to
fetch URL from any source.


