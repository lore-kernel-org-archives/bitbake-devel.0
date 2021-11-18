Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF2BC433EF
	for <webhook@archiver.kernel.org>; Thu, 18 Nov 2021 05:44:55 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web12.2004.1637214294129289265
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Nov 2021 21:44:54 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57,
 mailfrom: mark.hatle@kernel.crashing.org)
Received: from [192.168.2.107] ([70.99.78.137])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 1AI5ioT4032615;
	Wed, 17 Nov 2021 23:44:51 -0600
Message-ID: <f2be03cd-259c-bb13-3927-9a08f6011920@kernel.crashing.org>
Date: Wed, 17 Nov 2021 23:44:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [bitbake-devel] eSDK 'setscene whitelist'
Content-Language: en-US
To: Michail Kurochkin <michail.kurochkin@zorachka.com>,
        bitbake-devel@lists.openembedded.org
References: 
 <e234dbfabaaf26b609a594cf0d0e9aa5035350c7.camel@linuxfoundation.org>
 <2793.1637100915461282223@lists.openembedded.org>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <2793.1637100915461282223@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Nov 2021 05:44:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13065



On 11/16/21 4:15 PM, Michail Kurochkin wrote:
> xarina-build-dunfell/tmp/work/xarina_s_evb-poky-linux-gnueabi/xarina-s-evb-image-debug/1.0-r0/sdk-ext/image/tmp-renamed-sdk/tmp/stamps/xarina_s_evb-poky-linux-gnueabi/linux-xarina 
> :
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_build.sigbasedata.f7e0581ab0862694e68d70c3ea75af4cd09d12d2dc80c578e3020d5d84004d24
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_bundle_initramfs.sigbasedata.35dd9ae928f13ec025a03d1bbedb2ea05cbf9013809110ba4f94b3b20a21647a
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_checkuri.sigbasedata.7f538038d85f831a629e7fe35e6de396b1d42d345aa8591ee64886ae348553af

Looks like someone is using AUTOREV as your SRCREV.  If you do that, the system 
has to ALWAYS run the fetch operation to check if a new version of the component 
is available or not.

Instead pick a static commit, use that instead of AUTOREV in the recipe (or 
bbappend), and that should resolve the issue.

--Mark

>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_cleanall.sigbasedata.6bb9b07c233ac448fc38b389fb344b2875592d24f2a37fa8694251bde29e1256
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_clean.sigbasedata.d4b156e81ae2a9174326f4483b96aa9eab52dc9a6a87fc684dcfc1445dae2e2c
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_cleansstate.sigbasedata.b0fe786786fa0c3d5d3db669923b4130e81db33565ed100210af3bceff93d4e8
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_compile_kernelmodules.sigbasedata.88bceb2a9a223a010146ff1d0bd867c9f3d4b5e488df17a6b06bc306bcd59423
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_compile.sigbasedata.6ed8f6a2676ba19f3430b823b6a72ec0232e0743f32dd7d34abbee2781f3efae
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_configure.sigbasedata.339bae90c84c715c1d50b160e01bbd6db9cd837016eb84574ae723e1fd32aa64
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_deploy_setscene.sigbasedata.e78ab72e883eb6d98f3ab9cde98112204a9a1ff16b7d5889d8e8fb432beac783
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_deploy.sigbasedata.5c2ec19c5f16a3ccf72bdcc77244f69ecf06fcf4c3a30545c419ea9bacbee240
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_deploy_source_date_epoch_setscene.sigbasedata.763845042a23224650a503fabc4287e00eb81ff349cf28dda0047e8757c7110a
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_deploy_source_date_epoch.sigbasedata.0f69f14c141d908c721a5b1ccda17e7b1b88ae838de137857c270c2ffb820d8c
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_devpyshell.sigbasedata.2a74e89c8c0360cd6e1281da39d0a66c11fd7e571fd2bd7eebc02f6766fbe207
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_devshell.sigbasedata.4e8d2f6444ba0c9919cae79927e8e16c2ed777b892501d7a04cbc8b2939e85ac
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_diffconfig.sigbasedata.86ed27cdd5c5b3934e12296bca72c40b52a332f9b3d6cb350531d7970f412874
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_fetch.sigbasedata.5ab1a7e486a31a9944c59446c4c4135bf5d6961d767aa0456d140c6dd10ee1d8
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_install.sigbasedata.6fb52d153045a9b2233d31c90bd04f69f3baf2357893ceb1290c31a67f882a0d
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_kernel_add_regdb.sigbasedata.947c5189bfc6b4c01a42a1ba9d3052f85bdd332e907b667fc2565d0b356a88d4
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_kernel_link_images.sigbasedata.fa358feaf63e05aa2ade4a650c479a1feb4f74c176df2873607854894f51645a
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_listtasks.sigbasedata.12ae738d3561f977d3dc38ff7b21073cd916045f993f8be8e394b5b683ed26c9
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_menuconfig.sigbasedata.f4fd7c2860d845a7fdfbea5a727c24fa2373fa6b23eb99c3fac2e498639babfd
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_packagedata_setscene.sigbasedata.e78ab72e883eb6d98f3ab9cde98112204a9a1ff16b7d5889d8e8fb432beac783
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_packagedata.sigbasedata.6ecebd0eeb15e7963358218b990028456d039258ec81a3e277006f5fead0ecda
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_package_qa_setscene.sigbasedata.e78ab72e883eb6d98f3ab9cde98112204a9a1ff16b7d5889d8e8fb432beac783
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_package_qa.sigbasedata.15718e73ab4f2b0f47f4c3c0ffb0ae82117842f7e40eaedb4b9f666b7df9469c
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_package_setscene.sigbasedata.3e1a33a2a413b5cf8e7da487da52b7a64a5366e3d1eb1238a16cddc4f8fb98b8
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_package.sigbasedata.5d3b8b09899dfa4099111a1c1dd6df1f58dc0cd11eaf3c900cb81cb94a48c5b5
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_package_write_ipk_setscene.sigbasedata.64385b8d67399fcf96686c998012e79a3934afa900a4793fdaaba066c249d794
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_package_write_ipk.sigbasedata.192ebe1c2ae834f8fffe0c840c39b62ee0b1423256595547674653c42988a576
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_patch.sigbasedata.249ec0cba88dd64fcb1c9f3507736f78734ef3c2e5703747e442c95c87800df8
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_populate_lic_setscene.sigbasedata.e78ab72e883eb6d98f3ab9cde98112204a9a1ff16b7d5889d8e8fb432beac783
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_populate_lic.sigbasedata.b47980ee2cc961c089105d66ebb7e1689de782e3bc118e4e28aa23bf1d78dffb
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_populate_sysroot_setscene.sigbasedata.e78ab72e883eb6d98f3ab9cde98112204a9a1ff16b7d5889d8e8fb432beac783
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_populate_sysroot.sigbasedata.8c218fc9327c9f6f3353e4559d037d9b76c3fc65a9ec7c8374c07aca6938200a
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_prepare_recipe_sysroot.sigbasedata.4b2724167c5932203819023a5b7d39de232f015d4a6cc77269955c2738f6c65f
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_savedefconfig.sigbasedata.67d8b6f786936f07bed92cc8ccd9f6cc7aae56e6e7f82a5cd78bd67f8814b638
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_shared_workdir_setscene.sigbasedata.2113500ee55f4ee47685992a4fb70d0443710300b540846e9d95bc9a2d1d3f21
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_shared_workdir.sigbasedata.599b889326c0fdc255a5285271fcce91acaa8473d6d2f6ff485b001c4a30887a
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_sizecheck.sigbasedata.d3ca1d63314915c51f7c6737e33b1d3a993e33d9c3bab5b1833a79b2a16ec679
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_strip.sigbasedata.78ed0d14f18b848f3fd939d98b20912780332d726bb0dce7146d5f982142de88
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_symlink_kernsrc.sigbasedata.3548437dcad16ec9f5534906726b7b038bde4d514fad220fac0888af916de3a9
>          
> 3.14.62+gitAUTOINC+0e62087ecc-r1.do_unpack.sigbasedata.d8e25fffc33ef8e1d517784ef4d27f20a5af7eb18d3bdce2cf7de7335f7936d8
> I see that none of _setscene tasks was executed.
> I am really at a dead end. Could you please advice what can I do next to find 
> out the reason of this.
> I am a bit confused about your answer for 3.3
>  >>> It tells us if the task was run in entirety or whether it was restored from 
> sstate.
> Marking that _setscene task was or was not executed is definded in the same way 
> as for other tasks? I mean if there is a file xxx_setscene.sigbasedata.stamp 
> does it mean that task was executed? And if there is not such a file the task 
> was not executed. It is right?
> Looking forward to any help
> Thanks.
> Best Regards,
> Michail
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13064): https://lists.openembedded.org/g/bitbake-devel/message/13064
> Mute This Topic: https://lists.openembedded.org/mt/86995631/3616948
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [mark.hatle@kernel.crashing.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

