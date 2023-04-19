import '../../domain/entity/core_model.dart';

import 'common.dart';

List<TextSpan> buildTextWithId({
  required IdBase id,
  String? leadingText,
  String? trailingText,
  TextStyle? style,
}) =>
    [
      if (leadingText != null) TextSpan(text: leadingText),
      TextSpan(
        text: '${id.name}  ',
        style: style?.copyWith(fontWeight: FontWeight.w600) ?? textStyleBold,
      ),
      TextSpan(
        text: id is PeerId
            ? String.fromCharCode(emojiPeer[id.tokenEmojiByte])
            : String.fromCharCode(emojiVault[id.tokenEmojiByte]),
      ),
      if (trailingText != null) TextSpan(text: trailingText),
    ];

const emojiPeer = [
  0x1f3cf,
  0x1f3d0,
  0x1f3d1,
  0x1f3d2,
  0x1f3d3,
  0x1f9d6,
  0x1f9d7,
  0x1f9d8,
  0x1f9d9,
  0x1f9da,
  0x1f9db,
  0x1f9dc,
  0x1f9dd,
  0x1f3e0,
  0x1f3e1,
  0x1f3e2,
  0x1f3e3,
  0x1f3e4,
  0x1f3e5,
  0x1f3e6,
  0x1f9de,
  0x1f3e8,
  0x1f3e9,
  0x1f3ea,
  0x1f3eb,
  0x1f3ec,
  0x1f3ed,
  0x1f3ee,
  0x1f3ef,
  0x1f3f0,
  0x1f9df,
  0x1f3f4,
  0x1f9e0,
  0x1f9e2,
  0x1f3f8,
  0x1f3f9,
  0x1f3fa,
  0x1f9e3,
  0x1f9e4,
  0x1f9e5,
  0x1f9e6,
  0x1f400,
  0x1f401,
  0x1f402,
  0x1f403,
  0x1f404,
  0x1f405,
  0x1f406,
  0x1f407,
  0x1f408,
  0x1f409,
  0x1f40a,
  0x1f40b,
  0x1f40c,
  0x1f40d,
  0x1f40e,
  0x1f40f,
  0x1f410,
  0x1f411,
  0x1f412,
  0x1f413,
  0x1f414,
  0x1f415,
  0x1f416,
  0x1f417,
  0x1f418,
  0x1f419,
  0x1f41a,
  0x1f41b,
  0x1f41c,
  0x1f41d,
  0x1f41e,
  0x1f41f,
  0x1f420,
  0x1f421,
  0x1f422,
  0x1f423,
  0x1f424,
  0x1f425,
  0x1f426,
  0x1f427,
  0x1f428,
  0x1f429,
  0x1f42a,
  0x1f42b,
  0x1f42c,
  0x1f42d,
  0x1f42e,
  0x1f42f,
  0x1f430,
  0x1f431,
  0x1f432,
  0x1f433,
  0x1f434,
  0x1f435,
  0x1f436,
  0x1f437,
  0x1f438,
  0x1f439,
  0x1f43a,
  0x1f43b,
  0x1f43c,
  0x1f43d,
  0x1f43e,
  0x1f440,
  0x1f442,
  0x1f443,
  0x1f444,
  0x1f445,
  0x1f446,
  0x1f447,
  0x1f448,
  0x1f449,
  0x1f44a,
  0x1f44b,
  0x1f44c,
  0x1f44d,
  0x1f44e,
  0x1f44f,
  0x1f450,
  0x1f451,
  0x1f452,
  0x1f453,
  0x1f454,
  0x1f455,
  0x1f456,
  0x1f457,
  0x1f458,
  0x1f459,
  0x1f45a,
  0x1f45b,
  0x1f45c,
  0x1f45d,
  0x1f45e,
  0x1f45f,
  0x1f460,
  0x1f461,
  0x1f462,
  0x1f463,
  0x1f464,
  0x1f465,
  0x1f466,
  0x1f467,
  0x1f468,
  0x1f469,
  0x1f46a,
  0x1f46b,
  0x1f46c,
  0x1f46d,
  0x1f46e,
  0x1f46f,
  0x1f470,
  0x1f471,
  0x1f472,
  0x1f473,
  0x1f474,
  0x1f475,
  0x1f476,
  0x1f477,
  0x1f478,
  0x1f479,
  0x1f47a,
  0x1f47b,
  0x1f47c,
  0x1f47d,
  0x1f47e,
  0x1f47f,
  0x1f480,
  0x1f481,
  0x1f482,
  0x1f483,
  0x1f484,
  0x1f485,
  0x1f486,
  0x1f487,
  0x1f488,
  0x1f489,
  0x1f48a,
  0x1f48b,
  0x1f48c,
  0x1f48d,
  0x1f48e,
  0x1f48f,
  0x1f490,
  0x1f491,
  0x1f492,
  0x1f493,
  0x1f494,
  0x1f495,
  0x1f496,
  0x1f497,
  0x1f498,
  0x1f499,
  0x1f49a,
  0x1f49b,
  0x1f49c,
  0x1f49d,
  0x1f49e,
  0x1f49f,
  0x1f4a0,
  0x1f4a1,
  0x1f4a2,
  0x1f4a3,
  0x1f4a4,
  0x1f4a5,
  0x1f4a6,
  0x1f4a7,
  0x1f4a8,
  0x1f4a9,
  0x1f4aa,
  0x1f4ab,
  0x1f4ac,
  0x1f4ad,
  0x1f4ae,
  0x1f4af,
  0x1f4b0,
  0x1f4b1,
  0x1f4b2,
  0x1f4b3,
  0x1f4b4,
  0x1f4b5,
  0x1f4b6,
  0x1f4b7,
  0x1f4b8,
  0x1f4ba,
  0x1f4bb,
  0x1f4bc,
  0x1f4bd,
  0x1f4be,
  0x1f4bf,
  0x1f4c0,
  0x1f4c2,
  0x1f4c3,
  0x1f4c4,
  0x1f4c6,
  0x1f4c7,
  0x1f4c8,
  0x1f4c9,
  0x1f4ca,
  0x1f4cb,
  0x1f4cc,
  0x1f4cd,
  0x1f4ce,
  0x1f4cf,
  0x1f4d0,
  0x1f636,
  0x1f637,
  0x1f638,
  0x1f639,
  0x1f63a,
  0x1f63b,
  0x1f63c,
  0x1f63d,
  0x1f63e,
  0x1f63f,
  0x1f635,
];

const emojiVault = [
  0x1f640,
  0x1f641,
  0x1f642,
  0x1f643,
  0x1f644,
  0x1f645,
  0x1f646,
  0x1f647,
  0x1f648,
  0x1f649,
  0x1f64a,
  0x1f64c,
  0x1f64d,
  0x1f64e,
  0x1f64f,
  0x1f680,
  0x1f681,
  0x1f682,
  0x1f683,
  0x1f684,
  0x1f685,
  0x1f686,
  0x1f687,
  0x1f688,
  0x1f689,
  0x1f68a,
  0x1f68b,
  0x1f68c,
  0x1f68d,
  0x1f68e,
  0x1f68f,
  0x1f690,
  0x1f691,
  0x1f692,
  0x1f693,
  0x1f694,
  0x1f695,
  0x1f696,
  0x1f697,
  0x1f698,
  0x1f699,
  0x1f69a,
  0x1f69b,
  0x1f69c,
  0x1f69d,
  0x1f69e,
  0x1f69f,
  0x1f6a0,
  0x1f6a1,
  0x1f6a2,
  0x1f6a3,
  0x1f6a4,
  0x1f6a5,
  0x1f6a6,
  0x1f6a7,
  0x1f6a8,
  0x1f6a9,
  0x1f6aa,
  0x1f6ab,
  0x1f6ac,
  0x1f6ad,
  0x1f6ae,
  0x1f6af,
  0x1f6b0,
  0x1f6b1,
  0x1f6b2,
  0x1f6b3,
  0x1f6b4,
  0x1f6b5,
  0x1f6b6,
  0x1f6b7,
  0x1f6b8,
  0x1f6b9,
  0x1f6ba,
  0x1f6bb,
  0x1f6bc,
  0x1f6bd,
  0x1f6be,
  0x1f6bf,
  0x1f6c0,
  0x1f6c1,
  0x1f6c2,
  0x1f6c3,
  0x1f6c4,
  0x1f6c5,
  0x1f6cc,
  0x1f6d0,
  0x1f6d1,
  0x1f6d2,
  0x1f6eb,
  0x1f6ec,
  0x1f6f4,
  0x1f6f5,
  0x1f6f6,
  0x1f6f7,
  0x1f6f8,
  0x1f910,
  0x1f911,
  0x1f912,
  0x1f913,
  0x1f914,
  0x1f915,
  0x1f916,
  0x1f917,
  0x1f918,
  0x1f919,
  0x1f91a,
  0x1f91b,
  0x1f91c,
  0x1f91d,
  0x1f91e,
  0x1f91f,
  0x1f920,
  0x1f921,
  0x1f922,
  0x1f923,
  0x1f924,
  0x1f925,
  0x1f926,
  0x1f927,
  0x1f928,
  0x1f929,
  0x1f92a,
  0x1f92b,
  0x1f92c,
  0x1f92d,
  0x1f92e,
  0x1f92f,
  0x1f930,
  0x1f931,
  0x1f932,
  0x1f933,
  0x1f934,
  0x1f935,
  0x1f936,
  0x1f937,
  0x1f938,
  0x1f939,
  0x1f93a,
  0x1f93c,
  0x1f93d,
  0x1f93e,
  0x1f940,
  0x1f941,
  0x1f942,
  0x1f943,
  0x1f944,
  0x1f945,
  0x1f947,
  0x1f948,
  0x1f949,
  0x1f94a,
  0x1f94b,
  0x1f94c,
  0x1f950,
  0x1f951,
  0x1f952,
  0x1f953,
  0x1f954,
  0x1f955,
  0x1f956,
  0x1f957,
  0x1f958,
  0x1f959,
  0x1f95a,
  0x1f95b,
  0x1f95c,
  0x1f95d,
  0x1f95e,
  0x1f95f,
  0x1f960,
  0x1f961,
  0x1f962,
  0x1f963,
  0x1f964,
  0x1f965,
  0x1f966,
  0x1f967,
  0x1f968,
  0x1f969,
  0x1f96a,
  0x1f96b,
  0x1f980,
  0x1f981,
  0x1f982,
  0x1f983,
  0x1f984,
  0x1f985,
  0x1f986,
  0x1f987,
  0x1f988,
  0x1f989,
  0x1f98a,
  0x1f98b,
  0x1f98c,
  0x1f98d,
  0x1f98e,
  0x1f98f,
  0x1f990,
  0x1f991,
  0x1f992,
  0x1f993,
  0x1f994,
  0x1f995,
  0x1f996,
  0x1f997,
  0x1f9c0,
  0x1f9d0,
  0x1f9d1,
  0x1f9d2,
  0x1f9d3,
  0x1f9d4,
  0x1f9d5,
  0x1f4d2,
  0x1f4d3,
  0x1f4d4,
  0x1f4d5,
  0x1f4d6,
  0x1f4d7,
  0x1f4d8,
  0x1f4d9,
  0x1f4da,
  0x1f4db,
  0x1f4dc,
  0x1f4dd,
  0x1f4de,
  0x1f4df,
  0x1f4e0,
  0x1f4e1,
  0x1f4e2,
  0x1f4e3,
  0x1f4e4,
  0x1f4e5,
  0x1f4e6,
  0x1f4e7,
  0x1f4e8,
  0x1f4e9,
  0x1f4ea,
  0x1f4eb,
  0x1f4ec,
  0x1f4ed,
  0x1f4ee,
  0x1f4ef,
  0x1f4f0,
  0x1f4f1,
  0x1f4f2,
  0x1f4f3,
  0x1f4f5,
  0x1f4f6,
  0x1f4f7,
  0x1f4f8,
  0x1f4f9,
  0x1f4fa,
  0x1f4fb,
  0x1f4fc,
  0x1f4ff,
];
