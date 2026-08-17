Return-Path: <svsvenss@cisco.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1FFC5DF74
	for <webhook@archiver.kernel.org>; Mon, 17 Aug 2026 06:55:19 +0000 (UTC)
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24767.1786949709387110129
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 16 Aug 2026 23:55:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=SEEuBPgK;
 spf=pass (domain: cisco.com, ip: 173.37.86.77, mailfrom: svsvenss@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11949; q=dns/txt;
  s=iport01; t=1786949709; x=1788159309;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=ty+vurOJdasqS7i6cyyQGTDBl5PvKl4hns/Y1il0Ejc=;
  b=SEEuBPgKUdLRsmV+YGUnK893IqRoKeNNPJmlW5z1xCdpnUEhianbqZHU
   1JSTbEo4b6CUhB3yA+7NnVOfN8hsNfNJjwpMgWb0DXq/VQTW/TDA/J7oE
   FuxU3C2V3Sw7bn1NEtmZiWEW49AolZvDoZqIeIrs7ApQnTrMM8MRTiXT5
   DsWjWKYIeW6Duy+a3ovNoXfjBFkLhOmfGF+8sO2zEIqrEuIp2mruUnQEU
   aezDw30vVwsuYxwywHszp+dy9x+Cry6BLbYiiifNYw8mj2QoTKk3/STAP
   t1jxPksg82/y/1J5PIJ7fD6QLTM467fbEuIPQDuMsFhO+crEiTAJSIN4P
   w==;
X-CSE-ConnectionGUID: e7dPXiLlT9K3B2/6aED6tQ==
X-CSE-MsgGUID: p0wJF2sSSV6mPxOSeAvaXw==
X-IPAS-Result: =?us-ascii?q?A0BvAwBVr4Jq/47/Ja1aHgEBCxIMZYEgC4E9ATBTgQgCg?=
 =?us-ascii?q?SFJiCMDhSuIeQOeG4F0Cg8BAQENAi4BFQ0EAQGFBQKNaQImNAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4ZPDYZaAQEBAQMBeBACAQgRBAEBA?=
 =?us-ascii?q?S4nCh0IAgQBDQUIgnuCHRZBAwECDrpKAooceIE0gQHgORWBOIU/gx4BASqBN?=
 =?us-ascii?q?YJdgSMZG4NCgR8nG4INgRVCgmk+gmEEAYFfPINXgjAEgiJ6EhuCMTuQClJyI?=
 =?us-ascii?q?gMmMywBVRMXCwcFgSMQMwMqLy0jSwUtHXAMJxIPHRcXHlgbBgUSICpBRCMDP?=
 =?us-ascii?q?jiBCEECgXU/Ixk2fIEJXoErKmEBAhAXRi4VggoCgnOBKF4CAUkOC209NwYOG?=
 =?us-ascii?q?QMEgTUFjSsHWyCCRQEXZQkSJCAPaS2jdYF8oXsKhB6MIYhhhF2IMheFW6URm?=
 =?us-ascii?q?QgjjWebDgIEAgQFAhABAQY2gTI8gVlwFYMiCUoZD5c2xwZ5PQEBBwIHDgMLg?=
 =?us-ascii?q?WiQACyBUgEB?=
IronPort-PHdr: A9a23:hjUEoR/J3gyXRf9uWBDoyV9kXcBvk6//MghQ7YIolPcXNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8EqaQ==
IronPort-Data: A9a23:EwNNjarA01I6EMl54q6qtO06TUVeBmJHZBIvgKrLsJaIsI4StFCzt
 garIBnSPq7eYjCgLt4lbo/l8EMOuMfSndNlSAtqrStjFXsU8uPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9j8kif3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYgLNNwJcaDpOtfrT8Uw35ZwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0usoDVl+9
 NgcFGEuNTrZwLy/7Z7lVtA506zPLOGzVG8ekmtrwTecCbMtRorOBv2Xo9RZxzw3wMtJGJ4yZ
 eJANmEpN0uGOUASfA5LUvrSn8/w7pX7WyZGs0yYo7Esy2PS1wd2lrPqNbI5f/TXHJQExRfF+
 D6uE2LRGkkFFvLF0gG+zCypvv/opi7SRosiC+jtnhJtqBjJroAJMzUcVEexqPq0z0KzRd9bA
 0gV4TY1668q+UqmS9PwUxG1rDiDpBF0ZjZLO/cx5AfIzu/f5ByUQzBZCDVAc9ch8sQxQFTGy
 2O0oj8gPhQ22JW9QnOG/bDSpjS3URX550dbDcPYZWPpO+Xenbw=
IronPort-HdrOrdr: A9a23:m7FIZqjU+QHhDjTLtj8vEFa+93BQX9p23DAbv31ZSRFFG/FwyP
 re/8jzhCWVtN9OYhAdcIi7Sde9qBPnmaKc4eEqTNGftXrdyRqVxeBZnMTfKlLbalfDH4JmpM
 Ndmu1FeaLN5DtB/IjHCWuDYqsdKbC8mcjC65a9vhJQpENRGt1dBmxCe3+m+zhNNXJ77O0CZe
 KhD6R81l2dUEVSRP6WQlMCWO/OrcDKkpXJXT4qbiRM1CC+yRmTxPrfCRa34jcyOgkj/Z4StU
 TVmQ3w4auu98q81gLd0GHr6ZFXksvKy9dIBsCA4/JlawkEjDzGWK1RH5m5+BwlquCm71gn1P
 PWpQ07Ash143TNOkmovBrEwWDboXUTwk6n7WXdrWrooMT/Sj5/IdFGn5hlfhzQ7FdllM1g0Z
 hMw3mSu/NsfFH9dWXGlp31viNR5w2JSEkZ4KguZrtkINIjgYpq3MgiFYVuYc899WzBmdsa+a
 JVfbHhDb5tACCnhjbizylS6e3peGgvFRGbRUVHkMmU3z9K2E1d9SIjtZYidrNqzuNgd3GCjN
 60b5iBmNx1P70rRLM4C+EbTcStDGvRBRrKLWKJOFziULoKInTXtvfMkf8IDcyRCdQ1JaEJ6d
 /8eUIdsXR3d1PlCMWI0pEO+hfRQH+lVTCozs1F/ZB2trD1WbKuaES4ORwTutrlp+9aDtzQWv
 61Np4TC/j/LXH2EYIM2wHlQZFdJXQXTcVQsNcmXFCFpN7NN+TRx6HmWeeWIKCoHScvW2v5DH
 dGVD/vJN9Y5kTuQXP8iAi5YQKlRqU+x+MHLEH3xZll9GFWDPw4juE8syXM2v22
X-Talos-CUID: 9a23:LWVR/myrR3ztqE59k8+CBgUZRcwdQnz5yEuBABSSUyE3QZC5F0OprfY=
X-Talos-MUID: 9a23:DG5gCApLEn0zNlaiSxoezyk6K+VGub+VM35TlK0WnPKJHDJ5CyjI2Q==
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-05.cisco.com ([173.37.255.142])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 17 Aug 2026 06:55:08 +0000
Received: from rcdn-opgw-1.cisco.com (rcdn-opgw-1.cisco.com [72.163.7.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-05.cisco.com (Postfix) with ESMTPS id 487D8180007ED
	for <bitbake-devel@lists.openembedded.org>; Mon, 17 Aug 2026 06:55:08 +0000 (GMT)
X-CSE-ConnectionGUID: w4LQ7f3iTJOWqRAnk/jq2A==
X-CSE-MsgGUID: Co+fg4ZQQkCnz0cnq3A8/g==
Authentication-Results: rcdn-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,228,1779148800"; 
   d="scan'208,217";a="68127861"
Received: from mail-eastus2azon11011048.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.48])
  by rcdn-opgw-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 17 Aug 2026 06:55:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRqFLyCU9mGfiM+W8/9WDclKcIEpLKpyAUqJeMrQmSK6ub2aAiBH8PsgGMzhyfwoznRjOPUDDrVZ0TcrWau/qSObbzXL2doyqQGxo8XilPXOKwzKlrEXCSBSGnY9CQp5wq190zi4rAkBPzoAqoPxKnvlH/MkViKhYOS3ZMte4az/zKjKK7vvkZXLiKpM3bXe6lYfNMF7A/uOgXZVxL+MwABldsaf0/RDIoJIGG6T8QYHoTYS8McfPHb++mD21rROSjNlM+pzplKY8RGP6NX3uQbFzUQX/swLBNG3f7P96N4mZoMMoZ/u45Lwa2fA1+M6QgdJxoWWtLv2e2Ln4ZOBLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ty+vurOJdasqS7i6cyyQGTDBl5PvKl4hns/Y1il0Ejc=;
 b=K+7Xse9WkTT6ayxZwXuvfdS+XrQH6ph//Vfsvn4NNAk1zAaGl0T/Ypt9RWaXb7UV4wphTEYi8H8AlC08bcxzvrj575wpWOAobiZNGxCyya6BZ2lpxQQoCc2yOMzPDY6khftp1mFTS8pJMTL3LsQCOklFZSTzb3oIdcpEe3v1muluXohKKW+sXxZ8qYioTu+fYO4wmuQk2nonACQcB637MS+8xAg6nOwRLtqn1xHF1N/qB60sOp4sbsjIHAF7UwMMUCBtfzEUJr8WhQPUAw7nS+bS9kaEWYF706KBaEt8sI+olhqMGGC82XncM4FaVm/TNOmor6JydpdWUst7fN06tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DM6PR11MB3962.namprd11.prod.outlook.com (2603:10b6:5:192::26)
 by DS7PR11MB7835.namprd11.prod.outlook.com (2603:10b6:8:db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 06:55:05 +0000
Received: from DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161]) by DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 06:55:05 +0000
From: "Fredrik Svensson (svsvenss)" <svsvenss@cisco.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: 
 =?iso-8859-1?Q?Re:_[bitbake-devel]_[PATCH=A0v2]=A0fetch2/wget:=A0reuse=A0?=
 =?iso-8859-1?Q?cached=A0HTTPS=A0connections?=
Thread-Topic: 
 =?iso-8859-1?Q?[bitbake-devel]_[PATCH=A0v2]=A0fetch2/wget:=A0reuse=A0cach?=
 =?iso-8859-1?Q?ed=A0HTTPS=A0connections?=
Thread-Index: AQHdKnxaqgOfbFZ0Nk+1fTBcZToMq7adiqaAgABu5MaAABgrgIADwwav
Date: Mon, 17 Aug 2026 06:55:05 +0000
Message-ID: 
 <DM6PR11MB39624B046C4D0AD55A2ECF73CBA72@DM6PR11MB3962.namprd11.prod.outlook.com>
References: 
 <DM6PR11MB39625FB901F43B181E8B7C38CBDC2@DM6PR11MB3962.namprd11.prod.outlook.com>
	 <02b6e335731bb1bd9ddce4ce8867144c9491a2ed.camel@linuxfoundation.org>
	 <DM6PR11MB396271299B36AB33F27D6BE2CBDA2@DM6PR11MB3962.namprd11.prod.outlook.com>
 <2a1dfb64170ef90dde4f5def6fe7d86f720257f6.camel@linuxfoundation.org>
In-Reply-To: 
 <2a1dfb64170ef90dde4f5def6fe7d86f720257f6.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3962:EE_|DS7PR11MB7835:EE_
x-ms-office365-filtering-correlation-id: 0cecaa8d-a1d9-47f5-6f4e-08defc2c781e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|56012099006|5023799004|6133799003|4143699003|3023799007|22082099003|18002099003|8096899003|38070700021|13003099007;
x-microsoft-antispam-message-info: 
 vD1fn4MkVEbsdZ31KZxAJg6tH32xuyhwyXcvPhRGv+XSzZmEOn9YJ10RTcc3cFZgYpZFTtK8mwMPUokybABSNnvAn1g4mWqmLnFUb88PL8Hykm0LwSXnTUtjAQMPpfiYsNQkUtR3ZVt6vxjCrEPj8y+4GGKeryRY6BqspZyICMvMYv0PTLmz5uvhDEIC6CqlXnVlKXOSniyC8takqTmbl/Ut/TKglKZqpq13MnSS7zWZT4hAZWf6ovRMsWEOyK6X8ZZ33eWp5pR63aPzg9U3ivB6FkLotKXE7HDqphOuMeF1KEPJMDP81LHkiQWh9PvqthkZcFxfkyRjQSu2wn5ht+4xiSYaRIdPnVx5fjE+UGDigYOgBw51hgOYjB/DWKuU5DPAI65P422YqAtEvWQJbXNOg+X06ToZ4vSwzkPeHkSMRL2Xuyz0awOfqAkGJQhEvyHC+AAfId97Z6pMJ0VPdCBeJi6OxB+MqEeTWl9dxj9h33Lp7jvyUNwA37AT6UpQPqeHAJvwK5Cexyb9c3dqC+KFCv+WNC5/gCct46jfHuxWVMf0YoeaiNx7QGaICiLP9ff3LgR/JeXpZLb9MwqwsMuqVuZsbbI7vcf8E3yGvoas/5e7sKqSY0+cc5ztGrWtjWGaRWfAdoe5AVxBnHKF3CDLW1v/B1rtIiWx6gLMhsY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3962.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(5023799004)(6133799003)(4143699003)(3023799007)(22082099003)(18002099003)(8096899003)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?41U8nDW67zU0mmH1Xq+jElF9cRXItnLoXqeS+UVjVv1an7O/bTh4ltaeNE?=
 =?iso-8859-1?Q?I2eSxJJMhF4N6dXcCiecKUNBtBrnRjeEzM4E2/jO+9RUCJCvpU6uyjcx89?=
 =?iso-8859-1?Q?VrXCF51pHJiPuvZrcWcgirvUdublHZOi/xF9oV9qqdupIRtu0c+g9yK02A?=
 =?iso-8859-1?Q?ZyFhO7wxE9xW1nRZk7iGWO8keX3H7ApD95yD4B4QZuZw+XIPbp0PwXAxg4?=
 =?iso-8859-1?Q?YB3BsVe0qWGA3e2gHev74JIoZbEgSFph0KfHhadS1iRdYPylmVbiwyTeaB?=
 =?iso-8859-1?Q?v2B/iyi+H8mzP7ALvGcbXvs1AoYul51V+/7Oihj/YDzgqmlf90bgiHdAEM?=
 =?iso-8859-1?Q?FyvooyAwHGW3s1lGt0IWdkNtHPJ0fY//9BxuTE0zDWnjhzrdC7e2abSxzb?=
 =?iso-8859-1?Q?l8NbcpPRbjzHeSN3pUqm/+nCMGSpl1VISD6SqHblSzTOliU7+ATBGin9VI?=
 =?iso-8859-1?Q?UJEuyDJzBYuPe92yohYeS4EIx/mYVMhnWWa76p5abISGkampoQ7mCSUOJJ?=
 =?iso-8859-1?Q?u+L/kkOe/A1ykIlxQySHKOUd/MxcLkhANDbsTziUYfxw9A4qoAooZWTOYC?=
 =?iso-8859-1?Q?uv3rgqZzw9DlP3VwLFjAN0FGhziOR/WGlMlJJD+vXyVsr6pJSOyQh0KDhP?=
 =?iso-8859-1?Q?fsVCcmNVWklzYNV4KJsvGIdlpfBfun5w+UJSJ0QzUkzIt8I4uJCFGK0dCF?=
 =?iso-8859-1?Q?S/fnquw4QVFaU2/Cf1gheHKzuOTSSLL7Tx+uweqLIi1EfwgWpTKDCtkVtH?=
 =?iso-8859-1?Q?zrrNyrVCpShfXKIBPr3QxhyvmawNLjUkTJL+fLxZ0kphMvof6s/QelnvtS?=
 =?iso-8859-1?Q?qAiDHeHlUMvb5Xq6j+pt+BdayDZwyo/VOCeS2vqLyLP5qW5OqrFovhAC3T?=
 =?iso-8859-1?Q?hyCzaJyUsrwuLNJUc7wDYwr/Zt0un6t8JPSNybwdqtNg0e/HWzO2PrOnqI?=
 =?iso-8859-1?Q?Pw6TMkc6ZOkgUx62WzSKggiQsyVhc+jWA2fafDbe9jqLYV8pmHcg6DGhdv?=
 =?iso-8859-1?Q?uzfooUnXZnjGMLEIy88qOEdFNVU8F2WArTjS6+W+e4620cNJgzI12MQ7Iq?=
 =?iso-8859-1?Q?at9HOWpgBpgjk99/PDe89aXqm9uZxkbZBveIb2eUveV4avgnw53EoNkkP8?=
 =?iso-8859-1?Q?W3Z+j25OvwvE3XViMY38bMCAWorRs3/iqsaOV/XpjDTqjoJCkam2uLAw7V?=
 =?iso-8859-1?Q?B3g/vS3omXd3/Y5Zf4WAtahU6+le4OcRLBiBCosoiyxeAiwnNNstaSWZvD?=
 =?iso-8859-1?Q?qbas6ll6maEcaxKjAda90vD8CGcJVyRyRokUDYObEb+hEUEQIsFsTHKBNf?=
 =?iso-8859-1?Q?fnj3IIWYXMfIrb7rSWnmLFGoq9pd+Bbbz3y0FMe3D+6dWkP7I1vrh2YhQz?=
 =?iso-8859-1?Q?QkDQQ3TReQ8+qI7qJv3dgtS9GVfVbqgXFkJv+JXMOpVMIuM924BcVYRp75?=
 =?iso-8859-1?Q?Cp9takR7Qx/3cYLsax+eW0fGliBiY4xOjSFwUCPWtlqYq8b5aC9vWkt+Ru?=
 =?iso-8859-1?Q?x0A0olAKSNzZcEd+cwJCa+zZj0TqAiwtDJdRcKVeXVXQlNNjE4iWZrXuD/?=
 =?iso-8859-1?Q?9YZ3Bzw76PdRwJlKNkrEly0ENA2pXxRcMN+htgp9gm9mpxBCqpk9r4M7ke?=
 =?iso-8859-1?Q?nvAgo2xl5E7ojVzNOV43KWu62POMF00vpY2ivZp29aZjRRoPXoWUPMpGLI?=
 =?iso-8859-1?Q?6n4qaB8jqZmDwOt+pz5qQUfvuXLCTaTVIxMmuGE4pjIybSPi9iTEHUvbCt?=
 =?iso-8859-1?Q?zE3k+SpbndOD4YoMtKLVE9s6KWG3NjZRE7bnLPF+1VODLr?=
Content-Type: multipart/alternative;
	boundary="_000_DM6PR11MB39624B046C4D0AD55A2ECF73CBA72DM6PR11MB3962namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	SoiPf8NpOpSIkYNS37DVwlDzLEohM6gyNzgR5UTO7yG56YyZlq2rXE/4J7fjL08vbW8gYrO0WrvkyN/EmWyvV5SaoVYhHAwYITalX5mlQyLSHID9/wgH5QMCorwx1CtFxwisxxYPe/ilezvfCHBThOKdymPViFn6n3SXjhQpIHcR2COUWC+ZHp4BeynC5zSiS97QLNYXN6vcTrDX4/iJrrU2EMg6dv6UH0kTIWk3SnahyYWLmlcVXPnoR+vc3nHgMUHKxAcx7nSuAYtbiiYHDKZoGudpF0Z1aliBQ4607nHOgr1NBlN1nv/JPs/z2rafKgomPi3jWqUvxzTjvB7S0Q==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3962.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cecaa8d-a1d9-47f5-6f4e-08defc2c781e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 06:55:05.6850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPz2NuVPZZSiR3+EsITEg1bPDfXy1u5/3G6XN31f6rzreNJ50ZhaG0hMcPkR1sZgG9ZOxqyYXx2Fsto+aJanDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7835
X-Outbound-Client-TLS: ANONYMOUS;rcdn-opgw-1.cisco.com [72.163.7.162];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 72.163.7.162, rcdn-opgw-1.cisco.com
X-Outbound-Node: rcdn-l-core-05.cisco.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Aug 2026 06:55:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19968

--_000_DM6PR11MB39624B046C4D0AD55A2ECF73CBA72DM6PR11MB3962namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks, the new output makes the problem clearer.

The buildtools OpenSSL is trying to load its configuration from the
original SDK build path:

/usr/local/oe-sdk-hardcoded-buildpath/.../openssl.cnf

It looks like enable_tools_tarball() adds the buildtools binaries to
PATH, but does not source the scripts under environment-setup.d. The
OPENSSL_CONF value is set by environment-setup.d/openssl.sh, so
OpenSSL falls back to its compiled-in path instead.

I reproduced the same error with the 5.1 buildtools tarball when using
its OpenSSL without sourcing the complete environment. It works when
the environment is sourced normally.

I think the proper fix is for enable_tools_tarball() to import the complete
sourced environment, including the environment-setup.d scripts.

That would also explain why running the test manually over SSH works. I
think this is an issue with how yocto-autobuilder-helper imports the
buildtools environment, rather than with the BitBake HTTPS cache change.

Kind regards
Fredrik

________________________________
From: Richard Purdie <richard.purdie@linuxfoundation.org>
Sent: Friday, August 14, 2026 11:24 PM
To: Fredrik Svensson (svsvenss) <svsvenss@cisco.com>; bitbake-devel@lists.o=
penembedded.org <bitbake-devel@lists.openembedded.org>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH v2] fetch2/wget: reuse cached HTTPS con=
nections

On Fri, 2026-08-14 at 20:12 +0000, Fredrik Svensson via lists.openembedded.=
org wrote:
> The failure happens while the new self-test is generating its
> temporary certificate, before it exercises the HTTPS connection
> cache. Unfortunately, the test currently redirects both stdout and
> stderr to /dev/null, so the log only contains the exit status.
>
> I reproduced the command in an AlmaLinux 8 container using the same
> Yocto 5.1 buildtools, where it succeeds. This therefore looks
> specific to the alma8-vk-2worker, possibly its crypto/FIPS
> configuration or local state.
>
> I will prepare a small follow-up patch which captures the OpenSSL
> output and includes it in the log. A rerun with that patch should
> expose the actual reason.

Thanks, I applied it and the result was:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/4383/ste=
ps/15/logs/stdio

which suggests buildtools isn't working quite right. What is odd is
that if I ssh in and run that bitbake-selftest command on the same
build directory, it works and doesn't show the error. I'm not quite
sure what is going on here...

Cheers,

Richard

--_000_DM6PR11MB39624B046C4D0AD55A2ECF73CBA72DM6PR11MB3962namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
Thanks, the new output makes the problem clearer.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
The buildtools OpenSSL is trying to load its configuration from the</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
original SDK build path:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
/usr/local/oe-sdk-hardcoded-buildpath/.../openssl.cnf</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
It looks like enable_tools_tarball() adds the buildtools binaries to</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
PATH, but does not source the scripts under environment-setup.d. The</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
OPENSSL_CONF value is set by environment-setup.d/openssl.sh, so</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
OpenSSL falls back to its compiled-in path instead.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
I reproduced the same error with the 5.1 buildtools tarball when using</div=
>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
its OpenSSL without sourcing the complete environment. It works when</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
the environment is sourced normally.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
I think the proper fix is for enable_tools_tarball() to import the complete=
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
sourced environment, including the environment-setup.d scripts.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
That would also explain why running the test manually over SSH works. I</di=
v>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
think this is an issue with how yocto-autobuilder-helper imports the</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
buildtools environment, rather than with the BitBake HTTPS cache change.</d=
iv>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
Kind regards</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
Fredrik</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Richard Purdie &lt;ri=
chard.purdie@linuxfoundation.org&gt;<br>
<b>Sent:</b> Friday, August 14, 2026 11:24 PM<br>
<b>To:</b> Fredrik Svensson (svsvenss) &lt;svsvenss@cisco.com&gt;; bitbake-=
devel@lists.openembedded.org &lt;bitbake-devel@lists.openembedded.org&gt;<b=
r>
<b>Cc:</b> Mathieu Dubois-Briand &lt;mathieu.dubois-briand@bootlin.com&gt;<=
br>
<b>Subject:</b> Re: [bitbake-devel] [PATCH&nbsp;v2]&nbsp;fetch2/wget:&nbsp;=
reuse&nbsp;cached&nbsp;HTTPS&nbsp;connections</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Fri, 2026-08-14 at 20:12 +0000, Fredrik Svensso=
n via lists.openembedded.org wrote:<br>
&gt; The failure happens while the new self-test is generating its<br>
&gt; temporary certificate, before it exercises the HTTPS connection<br>
&gt; cache. Unfortunately, the test currently redirects both stdout and<br>
&gt; stderr to /dev/null, so the log only contains the exit status.<br>
&gt; <br>
&gt; I reproduced the command in an AlmaLinux 8 container using the same<br=
>
&gt; Yocto 5.1 buildtools, where it succeeds. This therefore looks<br>
&gt; specific to the alma8-vk-2worker, possibly its crypto/FIPS<br>
&gt; configuration or local state.<br>
&gt; <br>
&gt; I will prepare a small follow-up patch which captures the OpenSSL<br>
&gt; output and includes it in the log. A rerun with that patch should<br>
&gt; expose the actual reason.<br>
<br>
Thanks, I applied it and the result was:<br>
<br>
<a href=3D"https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/buil=
ds/4383/steps/15/logs/stdio">https://autobuilder.yoctoproject.org/valkyrie/=
#/builders/48/builds/4383/steps/15/logs/stdio</a><br>
<br>
which suggests buildtools isn't working quite right. What is odd is<br>
that if I ssh in and run that bitbake-selftest command on the same<br>
build directory, it works and doesn't show the error. I'm not quite<br>
sure what is going on here...<br>
<br>
Cheers,<br>
<br>
Richard<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR11MB39624B046C4D0AD55A2ECF73CBA72DM6PR11MB3962namp_--

